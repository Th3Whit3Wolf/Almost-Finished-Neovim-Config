packadd yats.vim
packadd vim-jsx-pretty
packadd vim-graphql
packadd vim-gutentags

if exists('tsfmt') || exists('clang-format') || exists('denofmt') || exists('prettier') || exists('tslint') || exists('eslint_d')
    packadd neoformat
endif

call LazySource('gutentags')

let g:coc_global_extensions += ['coc-emmet', 'coc-tsserver', 'coc-eslint', 'coc-tslint-plugin']

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat