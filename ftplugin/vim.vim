packadd vim-endwise
packadd vim-gutentags
packadd ale

call LazySource('gutentags')

let g:coc_global_extensions = g:coc_global_extensions + ['coc-vimlsp']
let g:endwise_no_mappings = v:true

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd
