packadd vim-css3-syntax
packadd bracey.vim
packadd vim-gutentags
packadd ale

if exists('css-beautify') || exists('csscomb') || exists('prettydiff') || exists('stylefmt') || exists('prettier') || exists('stylelint')
    packadd neoformat
endif

call LazySource('gutentags')

set backupcopy=yes
setlocal iskeyword+=-

let g:coc_global_extensions += ['coc-css']

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat