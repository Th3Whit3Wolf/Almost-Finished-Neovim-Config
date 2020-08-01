packadd vim-javascript
packadd vim-jsx-pretty
packadd vim-jsdoc
packadd vim-graphql
packadd vim-gutentags
packadd ale

if exists('js-beautify') || exists('clang-format') || exists('prettydiff') || exists('esformatter') || exists('prettier') || exists('prettier-eslint') || exists('eslint_d') || exists('standard') || exists('deno') || exists('semistandard')
    packadd neoformat
endif

call LazySource('gutentags')

let g:coc_global_extensions += ['coc-emmet', 'coc-tsserver', 'coc-eslint', 'coc-tslint-plugin']

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR
nmap <silent> <C-l> <Plug>(jsdoc)