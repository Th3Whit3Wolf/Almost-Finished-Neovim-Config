packadd vim-coffee-script
packadd vim-cjsx

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! CompileMyCode()
    if executable('coffee')
        call Run("coffee %")
    else
        echom 'Coffe is not installed!'
    endif
endfunction

autocmd BufWritePost *.coffee silent make!