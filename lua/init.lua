local global = require 'global'
local options = require 'options'
local variables = require 'variables'
local autocmd = require 'event'
local map = require 'mapping'
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
    if not global.isdir(global.python3) and vim.fn.executable('python3') then
        os.execute("mkdir -p " .. global.python3)
        os.execute("python3 -m venv " .. global.python3)
        -- install python language server, neovim host, and neovim remote
        vim.cmd("!" .. global.python3 .. "bin" .. global.path_sep ..
                    "pip install -U setuptools pynvim jedi 'python-language-server[all]' isort pyls-isort neovim-remote")
    end
    if not global.exists(global.node) and vim.fn.executable('npm') then
        -- install neovim node host
        os.execute("npm install -g neovim")
    end
    if not global.isdir(global.plugins .. 'opt' .. global.path_sep .. 'packer.nvim') then
        vim.fn.mkdir(global.plugins .. 'opt', 'p')
        local out = vim.fn.system(string.format(
            'git clone %s %s',
            'https://github.com/wbthomason/packer.nvim',
            global.plugins .. 'opt' .. global.path_sep .. 'packer.nvim'
        ))
        print(out)
        print("Downloading packer.nvim...")
        vim.cmd('set runtimepath+=' .. global.plugins .. 'opt' .. global.path_sep .. 'packer.nvim')
        require'plug'.install()
    end
    if not global.exists(global.local_nvim .. 'bin/') then
        os.execute("mkdir -p " .. global.local_nvim .. 'bin/')
        print("Downloading Quote Generator...")
        if vim.fn.executable('curl') then
            os.execute("curl -o ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz -LJO https://github.com/Th3Whit3Wolf/pquote/releases/download/0.2.0/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz")
            print("Unpacking Quote Generator...")
            os.execute("tar xzf ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz --directory ~/.local/share/nvim/bin/")
            print("Cleaning up Quote Generator...")
            os.execute("rm ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz")
            os.execute("mv ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc ~/.local/share/nvim/bin/pq")
        elseif vim.fn.executable('wget') then
            os.execute("wget --no-check-certificate --content-disposition -P ~/.local/share/nvim/bin/ https://github.com/Th3Whit3Wolf/pquote/releases/download/0.2.0/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz")
            print("Unpacking Quote Generator...")
            os.execute("tar xzf ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz --directory ~/.local/share/nvim/bin/")
            print("Cleaning up Quote Generator...")
            os.execute("rm ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc.tar.gz")
            os.execute("mv ~/.local/share/nvim/bin/pq-0.2.0-x86_64-unknown-linux-glibc ~/.local/share/nvim/bin/pq")
        end
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
    M.disable_distribution_plugins()
    M.leader_map()
    M.createdir()

    local ops = options:new()
    ops:load_options()

    local vars = variables:new()
    vars:load_variables()

    map.load_mapping()
    autocmd.load_autocmds()

    require 'plugins'
end

M.load_core()
