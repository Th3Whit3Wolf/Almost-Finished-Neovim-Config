vim = vim
local api = vim.api
local fn = vim.fn

local windows = {}

--- Strip leading and lagging whitespace
local function trim(str)
    return str:gsub("^%s+", ""):gsub("%s+$", "")
end

--- Get project_root_dir for git repository
function windows.project_root_dir()
    -- try file location first
    local gitdir = fn.system('cd "' .. fn.expand('%:p:h') .. '" && git rev-parse --show-toplevel')
    local isgitdir = fn.matchstr(gitdir, '^fatal:.*') == ""
    if isgitdir then
        return trim(gitdir)
    end

    -- try symlinked file location instead
    gitdir = fn.system('cd "' .. fn.fnamemodify(fn.resolve(fn.expand('%:p')), ':h') .. '" && git rev-parse --show-toplevel')
    isgitdir = fn.matchstr(gitdir, '^fatal:.*') == ""
    if isgitdir then
        return trim(gitdir)
    end

    -- just return current working directory
    return fn.getcwd(0, 0)
end

--- on_exit callback function to delete the open buffer when lazygit exits in a neovim terminal
function windows.on_exit(job_id, code, event)
    if code == 0 then
        -- Close the window where the BUFFER is
        vim.cmd("silent! :q")
        -- Cleanup
    end
end

--- open floating window with nice borders
function windows.open_floating_window(floating_window_scaling_factor, lazygit_floating_window_winblend,BUFFER, BUFFER_NAME, IS_LOADED)

    -- Why is this required?
    -- vim.g.lazygit_floating_window_scaling_factor returns different types if the value is an integer or float
    if type(floating_window_scaling_factor) == 'table' then
        floating_window_scaling_factor = floating_window_scaling_factor[false]
    end

    -- get dimensions
    local width = api.nvim_get_option("columns")
    local height = api.nvim_get_option("lines")

    -- calculate our floating window size
    local win_height = math.ceil(height * floating_window_scaling_factor) - 1
    local win_width = math.ceil(width * floating_window_scaling_factor)

    -- and its starting position
    local row = math.ceil(height - win_height) / 2
    local col = math.ceil(width - win_width) / 2

    -- set some border options
    local border_opts = {
        style = "minimal",
        relative = "editor",
        row = row - 1,
        col = col - 1,
        width = win_width + 2,
        height = win_height + 2,
    }

    -- set some options
    local opts = {
        style = "minimal",
        relative = "editor",
        row = row,
        col = col,
        width = win_width,
        height = win_height,
    }

    local border_lines = {'╭' .. string.rep('─', width) .. '╮'}
    local middle_line = '│' .. string.rep(' ', width) .. '│'
    for i = 1, height do
        table.insert(border_lines, middle_line)
    end
    table.insert(border_lines, '╰' .. string.rep('─', width) .. '╯')

    -- create a unlisted scratch buffer for the border
    local border_buffer = api.nvim_create_buf(false, true)

    -- set border_lines in the border buffer from start 0 to end -1 and strict_indexing false
    api.nvim_buf_set_lines(border_buffer, 0, -1, true, border_lines)
    -- create border window
    local border_window = api.nvim_open_win(border_buffer, true, border_opts)
    vim.cmd('set winhl=Normal:Floating')

    -- create a unlisted scratch buffer
    if BUFFER == nil then
        BUFFER = api.nvim_create_buf(false, true)
    else
        IS_LOADED = true
    end
    -- create file window, enter the window, and use the options defined in opts
    local _ = api.nvim_open_win(BUFFER, true, opts)

    vim.bo[BUFFER].filetype = BUFFER_NAME

    vim.cmd('setlocal bufhidden=hide')
    vim.cmd('setlocal nocursorcolumn')
    vim.cmd('set winblend=' .. lazygit_floating_window_winblend)

    -- use autocommand to ensure that the border_buffer closes at the same time as the main buffer
    local cmd = [[autocmd WinLeave <buffer> silent! execute 'hide']]
    vim.cmd(cmd)
    cmd = [[autocmd WinLeave <buffer> silent! execute 'silent bdelete! %s']]
    vim.cmd(cmd:format(border_buffer))
end

return windows