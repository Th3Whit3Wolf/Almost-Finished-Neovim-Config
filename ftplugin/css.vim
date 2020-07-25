packadd vim-css3-syntax
packadd bracey.vim
packadd vim-gutentags

call LazySource('gutentags')
set backupcopy=yes
setlocal iskeyword+=-
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR