packadd vim-less

function! CompileMyCode()
    if executable('less')
        call Run("lessc % > %:t:r.css")
    else
        echom 'Less compiler is not installed!'
    endif
endfunction
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR