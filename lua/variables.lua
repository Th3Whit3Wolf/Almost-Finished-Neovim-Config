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
    if global.isdir(global.python3 .. 'python') then
        self.python3_host_prog = global.python3 .. 'python'
    end
    if global.exists(global.node) then
        self.node_host_prog = global.node
    end
    -- Diagnostic Nvim settings
    self.diagnostic_insert_delay = 1
    self.diagnostic_show_sign = 1
    self.diagnostic_enable_underline = 0
    self.diagnostic_auto_popup_while_jump = 1
    self.diagnostic_enable_virtual_text = 1

    -- Completion Nvim settings
    -- Fix for completion with other plugins mapped to enter
    self.completion_confirm_key = ""
    -- Enable auto signature
    self.completion_enable_auto_signature = 1
    -- Auto change completion source
    self.completion_auto_change_source = 1
    -- Complete on delete
    self.completion_trigger_on_delete = 1
    -- ignore case matching
    self.completion_matching_ignore_case = 1

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

    -- Minimap
    self.minimap_auto_start = 1
    --self.minimap_highlight
    for name, value in pairs(self) do
        vim.g[name] = value
    end
end

return variables
