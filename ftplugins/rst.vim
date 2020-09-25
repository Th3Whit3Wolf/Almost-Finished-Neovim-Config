packadd vim-restructuredtext
packadd vim-lexical
packadd vim-pencil
packadd vim-ditto
packadd completion-tags
" packadd ale
packadd nvim-treesitter 
packadd completion-treesitter 
lua require 'plugins/tree-sitter' 
setlocal foldmethod=expr 
setlocal foldexpr=nvim_treesitter#foldexpr()

" DittoOn

call lexical#init()
call pencil#init({'wrap': 'hard'})

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'