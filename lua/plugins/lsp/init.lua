local diagnostic = require('diagnostic')
local completion = require('completion')
local nvim_lsp = require('nvim_lsp')
local global = require('global')
local vim = vim

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
        complete_items = {'vim-dadbod-completion', 'lsp'}
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

-- List of servers where config = {on_attach = on_attach}
local simple_lsp = { 'als', 'dockerls', 'elmls', 'html', 'jdtls', 'metals', 'ocamlls', 'purescriptls', 'rnix', 'sqlls', 'vimls', 'vuels', 'yamlls'}
-- List of installed LSP servers
local installed_lsp = vim.fn.systemlist('ls ~/.cache/nvim/nvim_lsp')
for k,_ in pairs(installed_lsp) do
    if installed_lsp[k] == "bashls" then
        nvim_lsp.bashls.setup {
            cmd = {'bash-language-server', 'start'},
            filetypes = {'sh', 'zsh'},
            root_dir = nvim_lsp.util.root_pattern('.git'),
            on_attach = on_attach
        }
    elseif installed_lsp[k] == "cssls" then
        nvim_lsp.cssls.setup {
            filetypes = {"", "scss", "less", "sass"},
            root_dir = nvim_lsp.util.root_pattern("package.json", ".git"),
            on_attach = on_attach
        }
    elseif installed_lsp[k] == "jsonls" then
        nvim_lsp.jsonls.setup {
            cmd = {'json-languageserver', '--stdio'},
            on_attach = on_attach
        }
    elseif installed_lsp[k] == "sumneko_lua" then
        nvim_lsp.sumneko_lua.setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT"
                    }
                }
            }
        }
    elseif installed_lsp[k] == "tsserver" then
        nvim_lsp.tsserver.setup {
            cmd = {"typescript-language-server", "--stdio"},
            filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx"},
            root_dir = nvim_lsp.util.root_pattern('package.json', 'tsconfig.json', '.git'),
            on_attach = on_attach
        }
    else
        for k,_ in pairs(simple_lsp) do
            if installed_lsp[k] == simple_lsp[k] then
                nvim_lsp[simple_lsp[k]].setup {
                    on_attach = on_attach
                }
            end
        end
    end
end

-- TODO
-- clojure
-- cmake
-- crystal
-- dart
-- gdscript3,gsl,gd
-- haskell
-- kotlin
-- latex,bib
-- R
-- ruby - solargraph
-- swift,obj-c
-- terraform

if vim.fn.executable(global.python3 .. 'bin' .. global.path_sep ..'pyls') then
    nvim_lsp.pyls.setup {
        cmd = {global.python3 .. 'bin' .. global.path_sep ..'pyls'},
        settings = {
            pyls = {
                executable = global.python3 .. 'bin' .. global.path_sep ..'pyls'
            }
        },
        on_attach = on_attach,
        root_dir = function(fname)
            return nvim_lsp.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg',
            'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc',
            '.gitignore')(fname)
            or nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
        end
    }
end

if vim.fn.executable('rust_analyzer') then
    nvim_lsp.rust_analyzer.setup {
        on_attach = on_attach,
    }
end