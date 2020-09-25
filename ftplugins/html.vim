packadd html5.vim
packadd bracey.vim
packadd vim-closetag
packadd completion-tags
" packadd ale
packadd vim-lexical
packadd vim-pencil
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()


call lexical#init()
call pencil#init({'wrap': 'soft'})

call LazySource('closetag')

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
