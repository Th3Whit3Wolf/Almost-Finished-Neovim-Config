packadd vimtex
packadd vim-latex-live-preview

setl updatetime=100

let g:livepreview_use_biber = 1

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR
