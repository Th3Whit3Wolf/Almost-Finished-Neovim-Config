packadd yats.vim
packadd vim-jsdoc
packadd vim-graphql
packadd vim-gutentags
packadd neoformat

call LazySource('gutentags')
let g:jsdoc_formatter = 'tsdoc'

nmap <silent> <C-l> <Plug>(jsdoc)
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat