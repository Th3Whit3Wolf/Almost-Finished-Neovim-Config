packadd vim-xml
packadd vim-closetag
packadd vim-gutentags
packadd ale

if exists('tidy') || exists('prettydiff') || exists('prettier')
    packadd neoformat
endif

call lexical#init()
call pencil#init({'wrap': 'soft', 'autoformat': 1})
call LazySource('gutentags')
call LazySource('closetag')

inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR

let g:lexical#thesaurus_key = '<leader>t'
let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

autocmd BufWritePre * undojoin | Neoformat