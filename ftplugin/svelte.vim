packadd vim-svelte-plugin

if exists('prettier')
    packadd neoformat
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

let g:vim_svelte_plugin_load_full_syntax = 1

autocmd BufWritePre * undojoin | Neoformat