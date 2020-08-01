packadd svg.vim
packadd vim-svg-indent
packadd vim-gutentags

let g:coc_global_extensions += ['coc-svg']

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR