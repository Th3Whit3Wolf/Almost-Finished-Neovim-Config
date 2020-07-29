packadd vimtex
packadd vim-latex-live-preview
packadd vim-gutentags
packadd neoformat

let g:tex_flavor="latex"
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
if exist('zathura')
    let g:vimtex_view_method='zathura'
endif

set conceallevel=1
setl updatetime=100

call LazySource('gutentags')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

function! CompileMyCode()
    if executable('latexmk')
        call Run("latexmk -pdf %")
    elseif executable('latexrun')
        call Run("latexrun %")
    elseif executable('textonic')
        call Run("textonic %")
    endif
endfunction
function! RunMyCode()
    LLPStartPreview
endfunction

autocmd BufWritePre * undojoin | Neoformat