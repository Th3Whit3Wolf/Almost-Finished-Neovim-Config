packadd vim-vue
packadd vim-graphql
packadd neoformat

let g:vue_pre_processors = 'detect_on_enter'

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat