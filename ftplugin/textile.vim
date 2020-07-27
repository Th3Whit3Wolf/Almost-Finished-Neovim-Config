packadd textile.vim
packadd vim-lexical
packadd vim-pencil
packadd vim-ditto

DittoOn

call lexical#init()
call pencil#init()

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>t'
let g:lexical#dictionary_key = '<leader>k'

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »