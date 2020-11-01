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
        local options = {noremap = true, silent = true}
        api.nvim_command("augroup vcsGit")
        if v.fn.executable('nvr') then
	        v.cmd("let $GIT_EDITOR = \"nvr -cc split --remote-wait +'set bufhidden=wipe'\"")
        end
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
        v.g.signify_sign_add = ''
        v.g.signify_sign_delete = ''
        v.g.signify_sign_delete_first_line = ''
        v.g.signify_sign_change = ''
        v.g.signify_sign_change = ''
        api.nvim_command("SignifyEnableAll")
        api.nvim_set_keymap("n", "\\<Space>gd", "<cmd>SignifyDiff<CR>",     options)
        api.nvim_set_keymap("n", "\\<Space>gp", "<cmd>SignifyHunkDiff<CR>", options)
        api.nvim_set_keymap("n", "\\<Space>gu", "<cmd>SignifyHunkUndo<CR>", options)
        api.nvim_set_keymap("n", "\\<Space>g[", "<Plug>(signify-prev-hunk)", {silent = true})
        api.nvim_set_keymap("n", "\\<Space>g]", "<Plug>(signify-next-hunk)", {silent = true})
        api.nvim_set_keymap("o", "ih", "<Plug>(signify-inner-pending)", {silent = true})
        api.nvim_set_keymap("x", "ih", "<Plug>(signify-inner-visual)",  {silent = true})
        api.nvim_set_keymap("o", "ah", "<Plug>(signify-outer-pending)", {silent = true})
        api.nvim_set_keymap("x", "ah", "<Plug>(signify-outer-visual)",  {silent = true})
        api.nvim_command("SignifyEnableAll")
        -- Gina
        api.nvim_command("packadd gina.vim")
        api.nvim_set_keymap("n", "<Space>gs", "<cmd>Gina status<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gb", "<cmd>Gina branch<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gc", "<cmd>Gina commit<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gC", "<cmd>Gina commit --amend<CR>", options)
        api.nvim_set_keymap("n", "<Space>gt", "<cmd>Gina tag<CR>",            options)
        api.nvim_set_keymap("n", "<Space>gl", "<cmd>Gina log<CR>",            options)
        api.nvim_set_keymap("n", "<Space>gL", "<cmd>Gina log :%<CR>",         options)
        api.nvim_set_keymap("n", "<Space>gf", "<cmd>Gina ls<CR>",             options)
        fn["gina#custom#command#option"]("commit", "-v|--verbose")
        fn["gina#custom#command#option"]([[/\%(status\|commit\)]], "-u|--untracked-files")
        fn["gina#custom#command#option"]("status", "-b|--branch")
        fn["gina#custom#command#option"]("status", "-s|--short")
        fn["gina#custom#command#option"]([[/\%(commit\|tag\)]], "--restore")
        fn["gina#custom#command#option"]("show", "--show-signature")
        fn["gina#custom#action#alias"]("branch", "track",  "checkout:track")
        fn["gina#custom#action#alias"]("branch", "merge",  "commit:merge")
        fn["gina#custom#action#alias"]("branch", "rebase", "commit:rebase")
        fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "preview", "topleft show:commit:preview")
        fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "changes", "topleft changes:of:preview")
        fn["gina#custom#mapping#nmap"]("branch", "g<CR>", "<Plug>(gina-commit-checkout-track)")
        fn["gina#custom#mapping#nmap"]("status", "<C-^>", ":<C-u>Gina commit<CR>", options)
        fn["gina#custom#mapping#nmap"]("commit", "<C-^>", ":<C-u>Gina status<CR>", options)
        fn["gina#custom#mapping#nmap"]("status", "<C-6>", ":<C-u>Gina commit<CR>", options)
        fn["gina#custom#mapping#nmap"]("commit", "<C-6>", ":<C-u>Gina status<CR>", options)
        fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]], "p",
            "<cmd>call gina#action#call(''preview'')<CR>", options)
        fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]],
            "c", "<cmd>call gina#action#call(''changes'')<CR>", options)
        -- Git Messenger
        api.nvim_command("packadd git-messenger.vim")
        v.g.git_messenger_no_default_mappings = true
        api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<CR>", {silent = true})
        api.nvim_command("packadd committia.vim")
    else
        api.nvim_command("augroup vcsGit")
        api.nvim_command("autocmd!")
        api.nvim_command("augroup END")
    end
end

return git