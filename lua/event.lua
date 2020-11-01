local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup ' .. group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function autocmd.load_autocmds()
    local definitions = {
        bufs = {
            -- Reload vim config automatically
            {"BufWritePost", [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]},
            -- Reload Vim script automatically if setlocal autoread
            {"BufWritePost,FileWritePost", "*.vim",
                [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]]},
            -- Disable swap/undo/viminfo/shada files in temp directories or shm
            {"BufNewFile,BufReadPre",
            "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
            "setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada="},
            {"BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile"},
            {"BufWritePre", "MERGE_MSG", "setlocal noundofile"}, {"BufWritePre", "*.tmp", "setlocal noundofile"},
            {"BufWritePre", "*.bak", "setlocal noundofile"}, {"BufLeave", "*", "silent! update"}
        },
        completion = {
            {"BufEnter", "*", "lua require'completion'.on_attach()"},
            -- Show diagnostic popup on cursor hold
            {"CursorHold", "*", "lua vim.lsp.util.show_line_diagnostics()"}
        },
        ScrollbarInit = {
            {"WinEnter,FocusGained,CursorMoved,VimResized", "*", "silent! lua require('scrollbar').show()"},
            {"WinLeave,FocusLost,CursorHold", "*", "silent! lua require('scrollbar').clear()"}
        },
        -- lazy_plugs = {},
        niceties = {
            {"Syntax", "*", [[if line('$') > 5000 | syntax sync minlines=300 | endif]]},
            {"BufEnter,WinEnter,InsertLeave,VimEnter", "*", "set cursorline"},
            {"BufLeave,WinLeave,InsertEnter", "*", "set nocursorline"},
            {"BufWritePost", "*",
                [[nested  if &l:filetype ==# '' || exists('b:ftdetect') | unlet! b:ftdetect | filetype detect | endif]]},
            {"BufReadPost", "*",
                [[if &ft !~# 'commit' && ! &diff && line("'\"") >= 1 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif]]}
        },
        --- Current window has hybrid numbers
        --- All other windows have absolute numbers
        numberToggle = {
            {"BufEnter,FocusGained,InsertLeave", "*", "set relativenumber"},
            {"BufLeave,FocusLost,InsertEnter", "*", "set norelativenumber"}
        },
        wins = {
            -- Highlight current line only on focused window
            {"WinEnter,InsertLeave", "*", [[if &ft !~# '^\(denite\|clap_\)' | set cursorline | endif]]},
            {"WinEnter,InsertLeave", "*", [[if &ft !~# '^\(denite\|clap_\)' | set nocursorline | endif]]},
            -- Equalize window dimensions when resizing vim window
            {"VimResized", "*", [[tabdo wincmd =]]},
            -- Force write shada on leaving nvim
            {"VimLeave", "*", "wshada!"},
            -- Check if file changed when its window is focus, more eager than 'autoread'
            {"BufEnter,FocusGained", "*", "checktime"}
        },
        better_diff = {
            {"FilterWritePost", "*",
                [[ if (&diff) | if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/diff.vim'))) == 0 | execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/diff.vim'))) | endif | DiffOrig | endif ]]}
        },
        better_term = {
            {"BufWinEnter,WinEnter", "term://*", "startinsert"}, {"BufLeave", "term://*", "stopinsert"},
            {"TermEnter", "*",
                [[ if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/terminal.vim'))) == 0 | execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/terminal.vim'))) | endif ]]}
        },
        yank = {
            {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]}
        },
        vcs = {
            {"BufEnter", "*", "lua require'myplugins/vcs'"}
        },
        lsp_installer = {
            {"FileType", "ada,cs,css,Dockerfile,yaml.docker-compose,elixir,elm,html,java,javascript,javascriptreact,json,json5,julia,less,lua,mysql,nim,nix,ocaml,php,purescript,reason,sass,scala,scss,sql,sh,typescript,typescriptreact,vb,vim,vue,yaml,zsh", "lua require('myplugins/lsp_install_prompt').lsp_installed()"}
        }
    }

    autocmd.nvim_create_augroups(definitions)
end

return autocmd