local diagnostic = require('diagnostic')
local completion = require('completion')
local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')
local util = require('nvim_lsp/util')

-- Configure the completion chains
local chain_complete_list = {
    default = {{
        complete_items = {'lsp', 'ts', 'snippet', 'buffers'}
    }, {
        complete_items = {'path'},
        triggered_only = {'/'}
    }, {
        complete_items = {'buffers'}
    }},
    string = {{
        complete_items = {'path'},
        triggered_only = {'/'}
    }},
    comment = {},
    sql = {{
        complete_items = {'vim-dadbod-completion', 'lsp'},
    }},
    vim = {{
        complete_items = {'snippet'}
    }, {
        mode = {'cmd'}
    }}
}

local on_attach = function(client, bufnr)
    diagnostic.on_attach(client, bufnr)
    completion.on_attach(client, bufnr, {
        sorting = 'alphabet',
        matching_strategy_list = {'exact', 'fuzzy', 'substring'},
        chain_complete_list = chain_complete_list
    })

    -- Keybindings for LSPs
    -- Note these are in on_attach so that they don't override bindings in a non-LSP setting
    vim.fn.nvim_buf_set_keymap(0, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", {
        noremap = true,
        silent = true
    })
    vim.fn.nvim_buf_set_keymap(0, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {
        noremap = true,
        silent = true
    })
    vim.fn.nvim_buf_set_keymap(0, "n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {
        noremap = true,
        silent = true
    })
    vim.fn.nvim_buf_set_keymap(0, "n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {
        noremap = true,
        silent = true
    })
    vim.fn.nvim_buf_set_keymap(0, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {
        noremap = true,
        silent = true
    })
    vim.fn.nvim_buf_set_keymap(0, "n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", {
        noremap = true,
        silent = true
    })
    vim.fn.nvim_buf_set_keymap(0, "n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {
        noremap = true,
        silent = true
    })
end

nvim_lsp.als.setup {
    on_attach = on_attach
}
nvim_lsp.bashls.setup {
    on_attach = on_attach
}
nvim_lsp.cssls.setup {
    on_attach = on_attach
}
nvim_lsp.dockerls.setup {
    on_attach = on_attach
}
nvim_lsp.elmls.setup {
    on_attach = on_attach
}
nvim_lsp.html.setup {
    on_attach = on_attach
}
nvim_lsp.jdtls.setup {
    on_attach = on_attach
}
nvim_lsp.jsonls.setup {
    on_attach = on_attach
}
nvim_lsp.metals.setup {
    on_attach = on_attach
}
nvim_lsp.ocamlls.setup {
    on_attach = on_attach
}
nvim_lsp.pyls.setup {
    on_attach = on_attach
}
nvim_lsp.purescriptls.setup {
    on_attach = on_attach
}
nvim_lsp.rnix.setup {
    on_attach = on_attach
}
nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach
}
nvim_lsp.sqlls.setup {
    on_attach = on_attach
}
nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach
}
nvim_lsp.tsserver.setup {
    on_attach = on_attach
}
nvim_lsp.vimls.setup {
    on_attach = on_attach
}
nvim_lsp.vuels.setup {
    on_attach = on_attach
}
nvim_lsp.yamlls.setup {
    on_attach = on_attach
}
