packass vim-crystal
packadd vim-endwise
packadd ale

if exists('crystal')
    packadd neoformat
endif

let g:endwise_no_mappings = v:true

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

autocmd BufWritePre * undojoin | Neoformat