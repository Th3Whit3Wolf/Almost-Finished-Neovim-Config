local global = require 'settings/global'
local options = require 'settings/options'
local variables = require 'settings/variables'
local autocmd = require 'settings/event'
local map = require 'settings/mapping'
local vim, api = vim, vim.api
local M = {}

-- Create all cache directories
-- Install python virtualenv and language server
function M.createdir()
    local data_dir = {global.cache_dir .. 'backup', global.cache_dir .. 'session', global.cache_dir .. 'swap',
                      global.cache_dir .. 'tags', global.cache_dir .. 'undo'}
    if not global.isdir(global.cache_dir) then
        os.execute("mkdir -p " .. global.cache_dir)
    end
    for _, v in pairs(data_dir) do
        if not global.isdir(v) then
            os.execute("mkdir -p " .. v)
        end
    end
    if not global.isdir(global.cache_dir .. 'venv/neovim3/') and global.exists('/usr/bin/python3') then
        os.execute("mkdir -p " .. global.cache_dir .. 'venv/neovim3/')
        os.execute("python3 -m venv " .. global.cache_dir .. 'venv/neovim3/bin/python')
        -- install python language server and neovim host
        os.execute(global.cache_dir .. 'venv/neovim3/python/bin/pip install -U pynvim jedi python-language-server[all] isort pyls-isort')
    end
    if not global.exists(os.getenv("HOME") .. '/.node_modules/bin/neovim-node-host') and global.exists('/usr/bin/npm') then
        -- install neovim node host
        os.execute("npm install -g neovim")
    end
    if not global.isdir(os.getenv("HOME") .. '/.local/share/nvim/site/pack/packer/opt/packer.nvim') then
        os.execute("git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim")
    end
end

function M.disable_distribution_plugins()
    vim.g.loaded_gzip = 1
    vim.g.loaded_tar = 1
    vim.g.loaded_tarPlugin = 1
    vim.g.loaded_zip = 1
    vim.g.loaded_zipPlugin = 1
    vim.g.loaded_getscript = 1
    vim.g.loaded_getscriptPlugin = 1
    vim.g.loaded_vimball = 1
    vim.g.loaded_vimballPlugin = 1
    vim.g.loaded_matchit = 1
    vim.g.loaded_matchparen = 1
    vim.g.loaded_2html_plugin = 1
    vim.g.loaded_logiPat = 1
    vim.g.loaded_rrhelper = 1
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.loaded_netrwSettings = 1
    vim.g.loaded_netrwFileHandlers = 1
    vim.g.loaded_fzf = 1
    vim.g.loaded_skim = 1
    vim.g.loaded_tutor_mode_plugin = 1
end

function M.leader_map()
    vim.g.mapleader = " "
    vim.fn.nvim_set_keymap('n', ' ', '', {
        noremap = true
    })
    vim.fn.nvim_set_keymap('x', ' ', '', {
        noremap = true
    })
end

function M.load_core()
    M.createdir()
    M.disable_distribution_plugins()
    M.leader_map()

    local ops = options:new()
    ops:load_options()

    local vars = variables:new()
    vars:load_variables()

    map.load_mapping()
    autocmd.load_autocmds()
end

M.load_core()
