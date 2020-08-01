packadd vim-signify
packadd vim-git
packadd committia.vim
packadd vim-pencil
packadd vim-lexical

hi! link SignifySignAdd OneHue4
hi! link SignifySignChange OneHue62
hi! link SignifySignDelete OneHue5

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »

call pencil#init({'wrap': 'soft', 'textwidth': 72})

let g:coc_global_extensions += ['coc-git']

let g:lexical#thesaurus = ['~/.config/nvim/thesaurus/mthesaur.txt', '~/.config/nvim/moby_thesaurus.txt']
let g:lexical#dictionary = ['/usr/share/dict/words']
let g:lexical#spellfile = ['~/.config/nvim/spell/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>lt'
let g:lexical#dictionary_key = '<leader>ld'

nmap  <silent> <leader>gm :if !exists('g:git_messenger_git_command') <bar> :packadd git-messenger.vim <bar>: call VimWhichGM() <bar> :endif <bar><CR> <Plug>(git-messenger)

function! VimWhichGM()
    let g:git_messenger_no_default_mappings = v:true
endfunction