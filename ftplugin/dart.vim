packadd dart-vim-plugin
packadd neoformat

let g:dart_html_in_string=v:true
let g:dart_style_guide = 2
let g:dart_format_on_save = 1

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat