packadd scss-syntax.vim
packadd vim-gutentags
packadd ale

if exists('csscomb') || exists('prettydiff') || exists('prettier') || exists('stylelint') || exists('stylefmt') || exists('sass-convert')
    packadd neoformat
endif

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! CompileMyCode()
    if executable('scssc')
        call Run("scssc  % > %:t:r.css")
    elseif executable('sass')
        call Run("sassc  % > %:t:r.css")
    else
        echom 'SCSS compiler is not installed!'
    endif
endfunction

autocmd BufWritePre * undojoin | Neoformat