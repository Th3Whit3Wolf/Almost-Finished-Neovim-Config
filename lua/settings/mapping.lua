local M = {}
local vim = vim
local mapping = {}
local rhs_options = {}

function mapping:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function mapping:load_vim_define()
    self.vim = {
        -- Vim map
        ["n|<C-x>"] = map_cr('bd!'):with_noremap(),
        ["n|<C-s>"] = map_cu('write'):with_noremap(),
        ["n|<C-z>"] = map_cu('undo'):with_noremap(),
        ["n|<C-S-z>"] = map_cu('redo'):with_noremap(),
        ["n|Y"] = map_cmd('y$'),
        ["n|q"] = map_cu('quit'),
        ["n|Q"] = map_cmd('q'):with_noremap(),
        ["n|qQ"] = map_cmd('@q'):with_noremap(),
        ["n|<Tab>"] = map_cmd('>>_'):with_noremap(),
        ["n|<S-Tab>"] = map_cmd('<<_'):with_noremap(),
        ["n|<C-h>"] = map_cmd('<C-w>h'):with_noremap(),
        ["n|<C-l>"] = map_cmd('<C-w>l'):with_noremap(),
        ["n|<C-j>"] = map_cmd('<C-w>j'):with_noremap(),
        ["n|<C-k>"] = map_cmd('<C-w>k'):with_noremap(),
        ["n|j"] = map_cmd('gk'):with_noremap(),
        ["n|k"] = map_cmd('gk'):with_noremap(),
        ["n|g"] = map_cmd('g^'):with_noremap(),
        ["n|h"] = map_cmd('g$'):with_noremap(),
        -- :: Start an external command with a single bang
        ["n|!"] = map_cmd(':!'):with_noremap(), 
        ["n|<CR>"] = map_cmd('za'):with_noremap(),
        ["n|<S-Return>"] = map_cmd('zMzvzt'):with_noremap(),
        -- Insert
        ["i|<C-s>"] = map_cmd('<Esc>:w<CR>'),
        ["i|<C-z>"] = map_cu('undo'):with_noremap(),
        ["i|<C-S-z>"] = map_cu('redo'):with_noremap(),
        ["i|<C-q>"] = map_cmd('<Esc>:wq<CR>'),
        -- Visual
        ["v|j"] = map_cmd('gk'):with_noremap(),
        ["v|k"] = map_cmd('gk'):with_noremap(),
        ["v|<Tab>"] = map_cmd('>gv'):with_noremap(),
        ["v|<S-Tab>"] = map_cmd('<gv'):with_noremap(),
        ["v|<C-s>"] = map_cu('write'):with_noremap(),
        ["v|<C-z>"] = map_cu('undo'):with_noremap(),
        ["v|<C-S-z>"] = map_cu('redo'):with_noremap(),
        -- Leader
        -- :: Splits
        ["n|<leader>sv"] = map_cr('vsplit'):with_noremap(),
        ["n|<leader>sh"] = map_cr('split'):with_noremap(),
        ["n|<leader>sq"] = map_cr('close'):with_noremap(),
        -- :: Toggle
        ["n|<leader>ts"] = map_cr('setlocal spell!'):with_noremap(),
        ["n|<leader>tn"] = map_cr('setlocal nonumber!'):with_noremap(),
        ["n|<leader>tl"] = map_cr('setlocal nolist!'):with_noremap(),
        -- :: Session Management
        ["n|<Leader>ss"] = map_cu('SessionSave'):with_noremap(),
        ["n|<Leader>sl"] = map_cu('SessionLoad'):with_noremap(),

    }
end

function mapping:load_plugin_define()
    self.plugin = {
        -- kyazdani42/nvim-tree.lua
        ["n|<leader>tf"] = map_cr("LuaTreeToggle"):with_noremap():with_silent(),
        ["n|<leader>rf"] = map_cr("LuaTreeRefresh"):with_noremap():with_silent(),
        ["n|<leader>ff"] = map_cr("LuaTreeFindFile"):with_noremap():with_silent(),
        -- nvim-lua/completion-nvim
        ["i|<TAB>"] = map_cmd([[pumvisible() ? "\<C-n>" : "\<Tab>"]]):with_expr():with_silent(),
        ["i|<S-TAB>"] = map_cmd([[pumvisible() ? "\<C-p>" : "\<S-Tab>"]]):with_noremap():with_expr():with_silent(),
            -- Allows completions to work with plugins that also map to enter
        ["i|''"] = map_cmd([[pumvisible() ? complete_info()["selected"] != "-1" ? "<Plug>(completion_confirm_completion)"  : "<c-e><CR>" :  "<CR>"]]):with_noremap():with_expr():with_silent(),
        
        -- dein
        -- ["n|<Leader>tr"] = map_cr("call dein#recache_runtimepath()"):with_noremap():with_silent(),
        -- ["n|<Leader>tf"] = map_cu('DashboardNewFile'):with_noremap():with_silent(),
        -- mhinz/vim-signify
        -- ["n|[g"] = map_cmd("<plug>(signify-next-hunk)"),
        -- ["n|]g"] = map_cmd("<plug>(signify-prev-hunk)"),
        -- a magic bind for regex [0-9]
        -- ["n|<Leader>,0,9"] = "<Plug>BuffetSwitch(+)",
        -- Plugin MarkdownPreview
        -- ["n|<Leader>om"] = map_cu('MarkdownPreview'):with_noremap():with_silent(),
        -- Plugin DadbodUI
        -- ["n|<Leader>od"] = map_cr('DBUIToggle'):with_noremap():with_silent(),
        -- Plugin Floaterm
        -- ["n|<A-d>"] = map_cu('FloatermToggle'):with_noremap():with_silent(),
        -- ["t|<A-d>"] = map_cu([[<C-\><C-n>:FloatermToggle<CR>]]):with_noremap():with_silent(),
        -- ["n|<Leader>g"] = map_cu('FloatermNew height=0.7 width=0.8 lazygit'):with_noremap():with_silent(),
        -- Far.vim
        -- ["n|<Leader>fz"] = map_cr('Farf'):with_noremap():with_silent(),
        -- ["v|<Leader>fz"] = map_cr('Farf'):with_noremap():with_silent(),
        -- Plugin Clap
        -- ["n|<Leader>tc"] = map_cu('Clap colors'):with_noremap():with_silent(),
        -- ["n|<Leader>bb"] = map_cu('Clap buffers'):with_noremap():with_silent(),
        -- ["n|<Leader>fa"] = map_cu('Clap grep'):with_noremap():with_silent(),
        -- ["n|<Leader>fb"] = map_cu('Clap marks'):with_noremap():with_silent(),
        -- ["n|<C-x><C-f>"] = map_cu('Clap filer'):with_noremap():with_silent(),
        -- ["n|<Leader>ff"] = map_cu('Clap files ++finder=rg --ignore --hidden --files'):with_noremap():with_silent(),
        -- ["n|<Leader>fg"] = map_cu('Clap gfiles'):with_noremap():with_silent(),
        -- ["n|<Leader>fw"] = map_cu('Clap grep ++query=<Cword>'):with_noremap():with_silent(),
        -- ["n|<Leader>fh"] = map_cu('Clap history'):with_noremap():with_silent(),
        -- ["n|<Leader>fW"] = map_cu('Clap windows'):with_noremap():with_silent(),
        -- ["n|<Leader>fl"] = map_cu('Clap loclist'):with_noremap():with_silent(),
        -- ["n|<Leader>fu"] = map_cu('Clap git_diff_files'):with_noremap():with_silent(),
        -- ["n|<Leader>fv"] = map_cu('Clap grep ++query=@visual'):with_noremap():with_silent(),
        -- ["n|<Leader>oc"] = map_cu('Clap dotfiles'):with_noremap():with_silent(),
        -- ["n|<Leader>s"] = map_cu('Clap gosource'):with_noremap():with_silent(),
        -- Plugin acceleratedjk
        -- ["n|j"] = map_cmd('<Plug>(accelerated_jk_gj)'):with_silent(),
        -- ["n|k"] = map_cmd('<Plug>(accelerated_jk_gk)'):with_silent(),
        -- Plugin QuickRun
        -- ["n|<Leader>r"] = map_cr("<cmd> lua require'quickrun'.run_command()"):with_noremap():with_silent(),
        -- Plugin Vista
        -- ["n|<Leader>v"] = map_cu('Vista!!'):with_noremap():with_silent(),
        -- Plugin SplitJoin
        -- ["n|sj"] = map_cr('SplitjoinJoin'),
        -- ["n|sk"] = map_cr('SplitjoinSplit'),
        -- Plugin go-nvim
        -- ["n|gcg"] = map_cr('GoAutoComment'):with_noremap():with_silent(),
        -- Plugin vim-operator-replace
        -- ["x|p"] = map_cmd("<Plug>(operator-replace)"),
        -- Plugin vim-operator-surround
        -- ["n|sa"] = map_cmd("<Plug>(operator-surround-append)"):with_silent(),
        -- ["n|sd"] = map_cmd("<Plug>(operator-surround-delete)"):with_silent(),
        -- ["n|sr"] = map_cmd("<Plug>(operator-surround-replace)"):with_silent()
    };
end

function M.nvim_load_mapping(mapping)
    for _, v in pairs(mapping) do
        for key, value in pairs(v) do
            local mode, keymap = key:match("([^|]*)|?(.*)")
            if type(value) == 'table' then
                local rhs = value.cmd
                local options = value.options
                vim.fn.nvim_set_keymap(mode, keymap, rhs, options)
            elseif type(value) == 'string' then
                local k, min, max = keymap:match("([^,]+),([^,]+),([^,]+)")
                for i = tonumber(min), tonumber(max) do
                    local map = (k .. "%s"):format(i)
                    local rhs = value:gsub("+", i)
                    vim.fn.nvim_set_keymap(mode, map, rhs, {})
                end
            end
        end
    end
end

function rhs_options:new()
    local instance = {
        cmd = '',
        options = {
            noremap = false,
            silent = false,
            expr = false
        }
    }
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function rhs_options:map_cmd(cmd_string)
    self.cmd = cmd_string
    return self
end

-- LuaTreeToggle => :LuaTreeToggle<CR>
function rhs_options:map_cr(cmd_string)
    self.cmd = (":%s<CR>"):format(cmd_string)
    return self
end

-- LuaTreeToggle => :<C-u>LuaTreeToggle<CR>
function rhs_options:map_cu(cmd_string)
    self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
    return self
end

function rhs_options:with_silent()
    self.options.silent = true
    return self
end

function rhs_options:with_noremap()
    self.options.noremap = true
    return self
end

function rhs_options:with_expr()
    self.options.expr = true
    return self
end

function map_cr(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cr(cmd_string)
end

function map_cmd(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cmd(cmd_string)
end

function map_cu(cmd_string)
    local ro = rhs_options:new()
    return ro:map_cu(cmd_string)
end

function M.load_mapping()
    local map = mapping:new()
    map:load_vim_define()
    map:load_plugin_define()
    M.nvim_load_mapping(map)
end

return M

