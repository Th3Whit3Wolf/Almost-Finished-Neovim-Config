packadd html5.vim
packadd bracey.vim
packadd vim-closetag
packadd vim-gutentags
packadd vim-lexical
packadd vim-pencil

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
let g:lexical#thesaurus_key = '<leader>t'
let g:lexical#dictionary_key = '<leader>k'

function! RunMyCode()
	Bracey
endfunction