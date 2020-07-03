packadd vim-signify
packadd vim-git
packadd committia.vim

nmap  <silent> <leader>gm :if !exists('g:git_messenger_git_command') <bar> :packadd git-messenger.vim <bar>: call VimWhichGM() <bar> :endif <bar><CR> <Plug>(git-messenger)

function! VimWhichGM()
    let g:git_messenger_no_default_mappings = v:true
endfunction