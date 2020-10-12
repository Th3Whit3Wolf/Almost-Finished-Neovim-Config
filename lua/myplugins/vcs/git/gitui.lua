-- Original work can be found here, https://github.com/kdheepak/gitui.nvim

vim.g.gitui_floating_window_winblend = 0
vim.g.gitui_floating_window_scaling_factor = 0.8
vim.g.gitui_use_neovim_remote = 1

local window = require 'utils/windows'
local vcs = require 'myplugins/vcs/git'

local vim = vim
local fn = vim.fn

GITUI_BUFFER = nil
GITUI_LOADED = false
vim.g.gitui_opened = 0

local function gitui_on_exit(job_id, code, event)
    if code == 0 then
        -- Close the window where the GITUI_BUFFER is
        vim.cmd("silent! :q")
        GITUI_BUFFER = nil
        GITUI_LOADED = false
        vim.g.gitui_opened = 0
    end
end

--- Call gitui
local function exec_gitui_command(cmd)
    if GITUI_LOADED == false then
        -- ensure that the buffer is closed on exit
        vim.g.gitui_opened = 1
        vim.fn.termopen(cmd, { on_exit = gitui_on_exit })
    end
    vim.cmd "startinsert"
end

--- :GitUI entry point
local function gitui(path)
    if path == nil then
        path = vcs.project_root_dir()
    end
    window.open_floating_window(vim.g.gitui_floating_window_scaling_factor, vim.g.gitui_floating_window_winblend, GITUI_BUFFER, 'gitui', GITUI_LOADED)
    local cmd = "gitui " .. "-p " .. path
    exec_gitui_command(cmd)
end

return {
    gitui = gitui,
}