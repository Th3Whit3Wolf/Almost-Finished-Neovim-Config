packadd vim-arduino-syntax

if exists('uncrustify') || exists('clang-format') || exists('astyle')
    packadd neoformat
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat