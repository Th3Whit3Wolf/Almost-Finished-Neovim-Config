packadd vim-vue
packadd vim-graphql

let g:vue_pre_processors = 'detect_on_enter'

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR