packadd vim-gutentags
packadd ale

if exists('uncrustify') || exists('astyle') || exists('clang-format') || exists('prettier')
    packadd neoformat
endif

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! CompileMyCode()
    if executable('javac')
        call Run("javac %")
    else
        echo 'Java is not installed!'
    endif
endfunction
function! RunMyCode()
    if executable('javac')
        call Run("javac %")
    else
        echo 'Java is not installed!'
    endif
endfunction

autocmd BufWritePre * undojoin | Neoformat