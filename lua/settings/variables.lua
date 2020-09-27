local global = require 'settings/global'
local vim = vim
local variables = {}

-- Set Variables
-- -------------------------- | ----
-- Global Variables           | vim.g
-- Buffer Variables           | vim.b
-- Window Variables           | vim.w
-- TabPage Variables          | vim.t 
-- Vim Variables (predefined) | vim.v

function variables:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function variables:load_variables()
    if global.isdir(global.cache_dir .. 'venv/neovim3/bin/python') then
        self.python3_host_prog = global.cache_dir .. 'venv/neovim3/bin/python'
    end
    if global.exists(os.getenv("HOME") .. '/.node_modules/bin/neovim-node-host') then
        self.node_host_prog = os.getenv("HOME") .. "/.node_modules/bin/neovim-node-host"
    end
    -- Diagnostic-nvim settings
    self.diagnostic_insert_delay = 1
    self.diagnostic_show_sign = 1
    self.diagnostic_enable_virtual_text = 1

    -- Fix for completion with other plugins mapped to enter
    self.completion_confirm_key = ""
    -- Fix for endwise with other plugins mapped to enter
    --self.endwise_no_mappings = "v:true"

    -- Disable provider for perl, python2, & ruby
    self.loaded_python_provider = 0
    self.loaded_ruby_provider = 0
    self.loaded_perl_provider = 0

    self.spaceline_seperate_style = 'slant'
    self.spaceline_diagnostic_tool = 'nvim_lsp'

    -- Use snippets.nvim for snippet completion
    self.completion_enable_snippet = 'snippets.nvim'

    self.rg_derive_root = true

    self.rainbow_guifgs = "'#ca754b', '#d26487', '#a15ea7', '#6981c5'"

    -- DB env variables for vim-dadbod-ui 
    self.db_ui_env_variable_url = 'DATABASE_URL'
    self.db_ui_env_variable_name = 'DATABASE_NAME'
    self.db_ui_save_location = global.cache_dir .. 'db_ui_queries'
    for name, value in pairs(self) do
        vim.g[name] = value
    end
end

return variables
