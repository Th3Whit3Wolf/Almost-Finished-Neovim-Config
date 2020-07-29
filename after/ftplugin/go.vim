function s:checkGoBins()
    if !exist('asfmt') || !exist('dlv') || !exist('errcheck') || !exist('fillstruct') || !exist('godef') || !exist('goimports') || !exist('golint') || !exist('gopls') || !exist('golangci-lint') || !exist('gomodifytags') || !exist('gorename') || !exist('gotags') || !exist('guru') || !exist('impl') || !exist('keyify') || !exist('motion') || !exist('iferr')
        GoInstallBinaries
    else
        GoUpdateBinaries
    endif
endfunction

autocmd BufEnter * if exist('go') | call <SID>checkGoBins() | endif
