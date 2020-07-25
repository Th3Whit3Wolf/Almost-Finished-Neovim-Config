" Source git settings
if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/git.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/git.vim')))
endif

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR