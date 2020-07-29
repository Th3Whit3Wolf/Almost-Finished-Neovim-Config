packadd vim-endwise
packadd vim-gutentags
packadd neoformat

call LazySource('gutentags')

let c_no_curly_error = 1
let g:endwise_no_mappings = v:true

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

autocmd BufWritePre * undojoin | Neoformat