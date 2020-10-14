local v = vim
local api = vim.api
local fn = vim.fn

local git = {}

--- Strip leading and lagging whitespace
local function trim(str)
    return str:gsub("^%s+", ""):gsub("%s+$", "")
end

--- Get project_root_dir for git repository
function git.project_root_dir()
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

--- Determine whether or not in a git repository
function git.is_git()
    local _, status = git.project_root_dir()
    if status == 1 then
        return true
    else
        return false
    end
end

function git.run()
    local _, status = git.project_root_dir()
    if status == 1 then
        api.nvim_command("augroup vcsGit")
        api.nvim_command("autocmd!")
        api.nvim_command("autocmd CursorHold * lua require'myplugins/vcs/git/gitlens'.blameVirtText()")
        api.nvim_command("autocmd CursorMoved * lua require'myplugins/vcs/git/gitlens'.clearBlameVirtText()")
        api.nvim_command("autocmd CursorMovedI * lua require'myplugins/vcs/git/gitlens'.clearBlameVirtText()")
        api.nvim_command("augroup END")
        if fn.executable("lazygit") then
            api.nvim_command("command! LazyGit lua require'myplugins/vcs/git/lazygit'.lazygit()")
            api.nvim_command("command! LazyGitFilter lua require'myplugins/vcs/git/lazygit'.lazygitfilter()")
            api.nvim_command("command! LazyGitConfig lua require'myplugins/vcs/git/lazygit'.lazygitconfig()")
        end
        if fn.executable("gitui") then
            api.nvim_command("command! GitUI lua require'myplugins/vcs/git/gitui'.gitui()")
        end
        -- Vim Signify
        api.nvim_command("packadd vim-signify")
        api.nvim_set_keymap("n", "\\<Space>gd", "<cmd>SignifyDiff<CR>",     {silent = true, noremap = true})
        api.nvim_set_keymap("n", "\\<Space>gp", "<cmd>SignifyHunkDiff<CR>", {silent = true, noremap = true})
        api.nvim_set_keymap("n", "\\<Space>gu", "<cmd>SignifyHunkUndo<CR>", {silent = true, noremap = true})

        api.nvim_set_keymap("n", "\\<Space>g[", "<Plug>(signify-prev-hunk)", {silent = true})
        api.nvim_set_keymap("n", "\\<Space>g]", "<Plug>(signify-next-hunk)", {silent = true})

        api.nvim_set_keymap("o", "ih", "<Plug>(signify-inner-pending)", {silent = true})
        api.nvim_set_keymap("x", "ih", "<Plug>(signify-inner-visual)",  {silent = true})
        api.nvim_set_keymap("o", "ah", "<Plug>(signify-outer-pending)", {silent = true})
        api.nvim_set_keymap("x", "ah", "<Plug>(signify-outer-visual)",  {silent = true})
        api.nvim_command("packadd gina.vim")
        -- Git Messenger
        api.nvim_command("packadd git-messenger.vim")
        v.g.git_messenger_no_default_mappings = true
        api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<CR>", {silent = true})
        api.nvim_command("packadd committia.vim")
        api.nvim_command("SignifyEnableAll")
    else
        api.nvim_command("augroup vcsGit")
        api.nvim_command("autocmd!")
        api.nvim_command("augroup END")
    end
end

return git