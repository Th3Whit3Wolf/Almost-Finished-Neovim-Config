packadd vim-ocaml
packadd vim-gutentags
packadd ale

if exists('ocamlformat') || exists('ocp-indent')
    packadd neoformat
endif

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat