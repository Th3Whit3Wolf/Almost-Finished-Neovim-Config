packadd vim-csharp
packadd omnisharp-vim
packadd ale

if exists('uncrustify') || exists('clang-format') || exists('astyle')
    packadd neoformat
endif

let g:coc_global_extensions = g:coc_global_extensions + ['coc-omnisharp']

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat