packadd ansible-vim
packadd vim-gutentags
packadd ale

let b:ale_linters = ['gcc']
let b:ale_fixer = ['remove_trailing_lines', 'trim_whitespace']

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR