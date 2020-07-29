packadd vim-closetag
packadd neoformat

call LazySource('closetag')

autocmd BufWritePre * undojoin | Neoformat