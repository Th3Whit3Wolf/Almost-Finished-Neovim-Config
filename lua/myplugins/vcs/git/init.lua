local vim = vim
local nv = vim.api
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
        nv.nvim_command("augroup vcsGit")
        nv.nvim_command("autocmd!")
        nv.nvim_command("autocmd CursorHold * lua require'myplugins/vcs/git/gitlens'.blameVirtText()")
        nv.nvim_command("autocmd CursorMoved * lua require'myplugins/vcs/git/gitlens'.clearBlameVirtText()")
        nv.nvim_command("autocmd CursorMovedI * lua require'myplugins/vcs/git/gitlens'.clearBlameVirtText()")
        nv.nvim_command("augroup END")
        if vim.fn.executable("lazygit") then
            nv.nvim_command("command! LazyGit lua require'myplugins/vcs/git/lazygit'.lazygit()")
            nv.nvim_command("command! LazyGitFilter lua require'myplugins/vcs/git/lazygit'.lazygitfilter()")
            nv.nvim_command("command! LazyGitConfig lua require'myplugins/vcs/git/lazygit'.lazygitconfig()")
        end
        if vim.fn.executable("gitui") then
            nv.nvim_command("command! GitUI lua require'myplugins/vcs/git/gitui'.gitui()")
        end
        nv.nvim_command("packadd vim-signify")
        nv.nvim_command("packadd gina.vim")
        nv.nvim_command("packadd git-messenger.vim")
        nv.nvim_command("packadd committia.vim")
        nv.nvim_command("SignifyEnableAll")
    else
        nv.nvim_command("augroup vcsGit")
        nv.nvim_command("autocmd!")
        nv.nvim_command("augroup END")
    end
end

return git