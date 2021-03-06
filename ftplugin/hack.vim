packadd vim-hack
packadd ale

" Automatic completion
let g:ale_completion_enabled = 1
" Include the linter name (e.g. 'hack' or 'hhast'), code, and message in errors
let g:ale_echo_msg_format = '[%linter%]% [code]% %s'
" Enable HHAST - this has security implications (see below)
let g:ale_linters = { 'hack': ['hack'] }

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR
