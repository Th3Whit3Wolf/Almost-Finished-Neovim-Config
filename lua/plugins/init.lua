local vim = vim

local plugins = {
    "nvim-lspconfig", -- Collection of common configurations for the Nvim LSP client.
    "lsp_extensions.nvim", -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
    "completion-nvim", -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
    "diagnostic-nvim", -- wrapsthe diagnostics setting to make it more user friendly
    -- "nvim-treesitter", -- Treesitter configurations and abstraction layer for Neovim. 
    -- "completion-treesitter", -- treesitter based completion sources.
    "completion-buffers", -- completion for buffers word.
    "vim-dadbod-completion", -- completion sources for vim-dadbod
    -- "completion-tags", -- Slightly improved ctags completion
    "nvim-web-devicons", -- devicons in lua
    "nvim-tree.lua", -- A File Explorer For Neovim Written In Lua
    "snippets.nvim", -- Snippets tool written in lua
    "nvim-colorizer.lua", -- high-performance color highlighter for Neovim
    "formatter.nvim", -- A format runner for neovim, written in lua
    "surround.nvim", -- A surround text object plugin for neovim written in lua.
    "plenary.nvim",
    "space-nvim-theme", -- My spacemacs colorscheme
    "Dusk-til-Dawn.nvim"
}

for _, plugin in ipairs(plugins) do
    -- Temporary work around for using lua plugins
    vim.cmd('packadd ' .. plugin)
end

require 'Dusk-til-Dawn'
require 'plugins/lsp'
require 'plugins/snippets'

-- Requires termguicolors to be set
require'colorizer'.setup {
    '*', -- Highlight all files, but customize some others.
    css = {
        css = true
    }, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    html = {
        names = false
    } -- Disable parsing "names" like Blue or Gray
}

require"surround".setup{}

vim.g.vista_default_executive = "ctags"
vim.g.vista_executive_for = {
    c          = "nvim_lsp",
    cpp        = "nvim_lsp",
    css        = "nvim_lsp",
    dockerfile = "nvim_lsp",
    fortran    = "nvim_lsp",
    go         = "nvim_lsp",
    lua        = "nvim_lsp",
    javascript = "nvim_lsp",
    python     = "nvim_lsp",
    ruby       = "nvim_lsp",
    rust       = "nvim_lsp",
    sh         = "nvim_lsp",
    tex        = "nvim_lsp",
    typescript = "nvim_lsp",
}