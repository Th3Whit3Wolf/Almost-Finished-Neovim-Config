packadd vim-json
packadd vim-gutentags
packadd ale

if exists('js-beautify') || exists('prettydiff') || exists('jq') || exists('prettier') || exists('prettier-eslint') || exists('fixjson') || exists('standard') || exists('deno') || exists('semistandard')
    packadd neoformat
endif

call LazySource('gutentags')

let g:coc_global_extensions += ['coc-json']

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat