packadd vim-yaml
packadd vim-gutentags
packadd ale

if exists('pyaml') || exists('prettier')
    packadd neoformat
endif

let g:coc_global_extensions += ['coc-yaml']

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR