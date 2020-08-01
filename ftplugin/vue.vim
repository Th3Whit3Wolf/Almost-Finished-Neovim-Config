packadd vim-vue
packadd vim-graphql
packadd ale

if exists('prettier')
    packadd neoformat
endif

let g:vue_pre_processors = 'detect_on_enter'

if executable('vls')
	let g:coc_global_extensions += ['coc-vetur']
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat