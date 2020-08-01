packadd Dockerfile.vim

if executable('docker')
	let g:coc_global_extensions += ['coc-docker']
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR