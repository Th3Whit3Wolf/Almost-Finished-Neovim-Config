require'nvim-treesitter.configs'.setup {
    refactor = {
        ensure_installed = "all",
        highlight = {
            enable = true
        },
        highlight_current_scope = {
            -- enable = true
        },
        highlight_definitions = {
            -- enable = true
        },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "crn"
            }
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "gd",
                list_definitions = "gD",
                goto_next_usage = "gnd",
                goto_previous_usage = "gpd"
            }
        }
    }
}
