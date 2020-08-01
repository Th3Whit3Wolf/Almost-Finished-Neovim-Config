packadd vim-elixir
packadd vim-endwise
packadd vim-gutentags
packadd ale

if exists('mix')
    packadd neoformat
endif

if executable('elixir') && executable('mix')
	let g:coc_global_extensions += ['coc-elixir']
endif

call LazySource('gutentags')

let g:endwise_no_mappings = v:true

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

autocmd BufWritePre * undojoin | Neoformat