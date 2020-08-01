packadd vimtex
packadd vim-latex-live-preview
packadd vim-lexical
packadd vim-pencil
packadd vim-ditto
packadd vim-gutentags
packadd ale

if exists('latexindent')
    packadd neoformat
endif

DittoOn

call lexical#init()
call pencil#init()

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

let g:tex_flavor="latex"
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

if exist('zathura')
    let g:vimtex_view_method='zathura'
endif

if executable('texlab')
	let g:coc_global_extensions += ['coc-texlab']
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