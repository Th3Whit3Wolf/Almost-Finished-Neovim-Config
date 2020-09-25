packadd vim-matlab
packadd completion-tags
" packadd ale

let b:endwise_addition = 'end'
let b:endwise_words = 'function,if,for'
let b:endwise_syngroups = 'matlabStatement,matlabFunction,matlabConditional,matlabRepeat'

if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/git.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/vim-endwise.vim')))
endif

imap <buffer> <CR> <CR><Plug>DiscretionaryEnd