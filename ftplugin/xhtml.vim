packadd vim-closetag
packadd ale

if exists('tidy') || exists('prettydiff')
    packadd neoformat
endif

call LazySource('closetag')

autocmd BufWritePre * undojoin | Neoformat