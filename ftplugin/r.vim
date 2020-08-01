packadd Nvim-R
packadd ale

if exists('R')
	packadd neoformat
endif

if executable('r')
	let g:coc_global_extensions += ['coc-r-lsp']
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat