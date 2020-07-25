packadd html5.vim
packadd bracey.vim
packadd vim-closetag
packadd vim-gutentags

call LazySource('gutentags')
call LazySource('closetag')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

set backupcopy=yes
let g:bracey_refresh_on_save = 1
function! RunMyCode()
	Bracey
endfunction