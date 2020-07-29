packadd vim-csharp
packadd neoformat

let g:coc_global_extensions = g:coc_global_extensions + ['coc-omnisharp']

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat