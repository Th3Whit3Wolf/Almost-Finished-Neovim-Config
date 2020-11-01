local global = require 'global'
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
    if global.isdir(global.python3 .. 'bin' .. global.path_sep .. 'python') then
        self.python3_host_prog = global.python3 .. 'bin' .. global.path_sep .. 'python'
    end
    if global.exists(global.node) then
        self.node_host_prog = global.node
    end

    -- Disable provider for perl, python2, & ruby
    self.loaded_python_provider = 0
    self.loaded_ruby_provider = 0
    self.loaded_perl_provider = 0

    -- Spaceline settings
    self.spaceline_colorscheme = 'spacer'
    self.spaceline_seperate_style = 'slant'
    self.spaceline_diagnostic_tool = 'nvim_lsp'

    self.rg_derive_root = true

    -- Rainbow Parentheses
    self["rainbow#pairs"] = [['(', ')'], ['[', ']'], ['<', '>']]

    -- DB env variables for vim-dadbod-ui
    self.db_ui_env_variable_url = 'DATABASE_URL'
    self.db_ui_env_variable_name = 'DATABASE_NAME'
    self.db_ui_save_location = global.cache_dir .. 'db_ui_queries'

    -- Minimap
    self.minimap_auto_start = 1
    --self.minimap_highlight = comment

    for name, value in pairs(self) do
        vim.g[name] = value
    end
end

return variables
