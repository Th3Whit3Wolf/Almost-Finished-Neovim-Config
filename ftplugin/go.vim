packadd vim-go
packadd vim-gutentags

call LazySource('gutentags')
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! CompileMyCode()
    if executable('go')
        call Run("go build %")
    else
        echo 'Go is not installed!'
    endif
endfunction
function! RunMyCode()
    if executable('go')
        call Run("go run %")
    else
        echo 'Go is not installed!'
    endif
endfunction
