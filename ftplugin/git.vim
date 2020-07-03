" Source git settings
if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/git.vim'))) == 0
    execute 'source' fnameescape(abspath)
    return
endif