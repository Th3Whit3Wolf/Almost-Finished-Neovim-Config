packadd vim-toml

if expand('%') =~ "Cargo.toml"
    packadd vim-crates
    call crates#toggle()
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR