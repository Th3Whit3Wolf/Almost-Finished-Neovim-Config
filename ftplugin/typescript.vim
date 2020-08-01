packadd yats.vim
packadd vim-jsdoc
packadd vim-graphql
packadd vim-gutentags
packadd ale

if exists('tsfmt') || exists('clang-format') || exists('denofmt') || exists('prettier') || exists('tslint') || exists('eslint_d')
    packadd neoformat
endif

call LazySource('gutentags')

let g:coc_global_extensions += ['coc-emmet', 'coc-tsserver', 'coc-eslint', 'coc-tslint-plugin']
let g:jsdoc_formatter = 'tsdoc'

nmap <silent> <C-l> <Plug>(jsdoc)
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat