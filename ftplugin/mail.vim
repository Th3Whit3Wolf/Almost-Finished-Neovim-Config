packadd vim-lexical
packadd vim-pencil
packadd vim-ditto

DittoOn

call lexical#init()
call pencil#init({'wrap': 'hard', 'textwidth': 60})

setl spell spl=en_us et sw=2 ts=2 noai nonu nornu

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>t'
let g:lexical#dictionary_key = '<leader>k'