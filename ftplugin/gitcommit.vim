"packadd ale

setlocal spell
setlocal textwidth=72

" Source git settings
if !stridx(&rtp, resolve(expand('~/.config/nvim/lazy/git.vim'))) == 0
    execute 'source' fnameescape(resolve(expand('~/.config/nvim/lazy/git.vim')))
endif

" Strip space on save.
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()