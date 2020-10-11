function! is_vcs#is_git()
    let git_dir = system('git rev-parse --git-dir')
	" if in a git repo
	if !v:shell_error
        return 1
    else 
        if expand("%:p:h") !~ '^/tmp' 
            silent! lcd %:p:h
        endif
        let git_dir = system('git rev-parse --git-dir')
        " if in a git repo
        if !v:shell_error
            command! LazyGit lua require'myplugins/lazygit'.lazygit()
            command! LazyGitFilter lua require'myplugins/lazygit'.lazygitfilter()
            command! LazyGitConfig lua require'myplugins/lazygit'.lazygitconfig()
            return 1
        else 
            return 0
        endif
    endif
endfunction()