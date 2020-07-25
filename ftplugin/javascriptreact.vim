packadd vim-js
packadd vim-jsx-pretty
packadd vim-jsdoc
packadd vim-graphql
packadd vim-gutentags

call LazySource('gutentags')
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR
nmap <silent> <C-l> <Plug>(jsdoc)