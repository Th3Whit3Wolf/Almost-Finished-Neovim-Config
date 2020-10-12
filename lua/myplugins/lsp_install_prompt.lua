local vim, api = vim, vim.api
local next = next
local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
local global = require('global')

local lsp_prompt = {}
--- Prompt use if they would like to donwload lsp
function prompt(lsp)
    if next(vim.lsp.get_active_clients()) == nil then
        if vim.fn.input("Language server (" .. lsp .. ") is available for " .. ft .. ". Download now? (y for yes)") ~=
            "y" then
            return
        end
        api.nvim_command("LspInstall " .. lsp)
    else
        return
    end
end

local lsps = {
    ada = "als",
    cs = "omnisharp",
    css = "cssls",
    Dockerfile = "dockerls",
    ["yaml.docker-compose"] = "dockerls",
    elm = "elmls",
    html = "html",
    java = "jdtls",
    javascript = "tsserver",
    javascriptreact = "tsserver",
    json = "jsonls",
    json5 = "jsonls",
    less = "cssls",
    lua = "sumneko_lua",
    mysql = "sqlls",
    nix = "rnix",
    ocaml = "ocamlls",
    purescript = "purescriptls",
    reason =  "ocamlls",
    sass = "cssls",
    scala = "metals",
    scss = "cssls",
    sql = "sqlls",
    sh = "bashls",
    typescript = "tsserver",
    typescriptreact = "tsserver",
    vb = "omnisharp",
    vim = "vimls",
    vue = "vuels",
    yaml = "yamlls",
    zsh = "bashls",
}
if vim.fn.executable('mix') then
    lsps["elixir"] = "elixirls"
end
if vim.fn.executable('composer') then
    lsps["php"] = "intelphense"
end
if vim.fn.executable('julia') then
    lsps["julia"] = "julials"
end
if vim.fn.executable('nimble') then
    lsps["nim"] = "nimls"
end

function lsp_prompt.lsp_installed()
    local all = api.nvim_exec(':LspInstallInfo', true)
    if lsps[ft] ~= nil then
        if not string.match(all, lsps[ft]) then
            prompt(lsps[ft])
        end
    end
end

function lsp_prompt.check_lsp_installed()
    local all = api.nvim_exec(':LspInstallInfo', true)
    if lsps[ft] ~= nil then
        if not string.match(all, lsps[ft]) then
            prompt(lsps[ft])
        else
            print('LSP '.. lsps[ft] .. ' is installed')
        end
    elseif ft == "python" and vim.fn.executable(global.python3 .. 'bin' .. global.path_sep ..'pyls') then
        print('LSP pyls is installed')
    elseif ft == "rust" and vim.fn.executable('rust-analyzer') then
        print('LSP rust-analyzer is installed')
    else
        print('LSP not detected')
    end
end

return lsp_prompt
