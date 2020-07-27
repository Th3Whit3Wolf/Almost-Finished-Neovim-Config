packadd vim-signify
packadd vim-git
packadd committia.vim
packadd vim-pencil

setl spell spl=en_us et sw=2 ts=2 noai

" replace common punctuation
iabbrev <buffer> -- –
iabbrev <buffer> --- —
iabbrev <buffer> << «
iabbrev <buffer> >> »

call pencil#init({'wrap': 'hard', 'textwidth': 72})

nmap  <silent> <leader>gm :if !exists('g:git_messenger_git_command') <bar> :packadd git-messenger.vim <bar>: call VimWhichGM() <bar> :endif <bar><CR> <Plug>(git-messenger)

function! VimWhichGM()
    let g:git_messenger_no_default_mappings = v:true
endfunction