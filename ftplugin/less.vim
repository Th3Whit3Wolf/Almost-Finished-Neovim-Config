packadd vim-less
packadd ale

if exists('csscomb') || exists('prettydiff') || exists('prettier') || exists('stylelint')
    packadd neoformat
endif

function! CompileMyCode()
    if executable('less')
        call Run("lessc % > %:t:r.css")
    else
        echom 'Less compiler is not installed!'
    endif
endfunction

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

autocmd BufWritePre * undojoin | Neoformat