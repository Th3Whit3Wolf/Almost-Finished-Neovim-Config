packadd vim-clojure-static
packadd vim-fireplace
packadd vim-clojure-highlight
packadd vim-gutentags

call LazySource('gutentags')
" Note: https://github.com/Olical/conjure looks interesting

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR