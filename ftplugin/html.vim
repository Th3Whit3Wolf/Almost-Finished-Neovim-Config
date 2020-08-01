packadd html5.vim
packadd bracey.vim
packadd vim-closetag
packadd vim-gutentags
packadd vim-lexical
packadd vim-pencil
packadd ale

if exists('tidy') || exists('prettier') || exists('html-beautify') || exists('prettydiff')
    packadd neoformat
endif

let g:coc_global_extensions += ['coc-svg', 'coc-html', 'coc-emmet']

call lexical#init()
call pencil#init({'wrap': 'soft'})

call LazySource('gutentags')
call LazySource('closetag')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

set backupcopy=yes

let g:bracey_refresh_on_save = 1
let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

function! RunMyCode()
	Bracey
endfunction

autocmd BufWritePre * undojoin | Neoformat