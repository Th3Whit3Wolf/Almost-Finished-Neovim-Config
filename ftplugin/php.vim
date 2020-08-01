packadd php.vim
packadd vim-gutentags
packadd ale

if exists('php_beautifier') || exists('php-cs-fixer') || exists('phpcbf')
    packadd neoformat
endif

call LazySource('gutentags')

if executable('php')
	let g:coc_global_extensions += ['coc-phpls']
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat