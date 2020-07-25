packadd vim-lua
packadd vim-endwise
packadd vim-gutentags

call LazySource('gutentags')
let g:endwise_no_mappings = v:true
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd
let g:lua_syntax_fancynotequal = 1