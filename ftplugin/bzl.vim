google/vim-maktaba
bazelbuild/vim-bazel

if exists('buildifier')
    packadd neoformat
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat