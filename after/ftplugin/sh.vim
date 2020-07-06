function s:shellbang() abort
    let options  = [
        \ 'ash',
        \ 'bash',
        \ 'csh',
        \ 'dash',
        \ 'fish',
        \ 'ksh',
        \ 'ion',
        \ 'mksh',
        \ 'pdksh',
        \ 'sh',
        \ 'tcsh',
        \ 'zsh',
        \ 'none'
        \ ]

    unsilent let choice = inputlist([ 'Select your shell:' ]
        \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(options)) - 2)
        if choice == 5
            set ft=fish
        elseif choice == 7
            set ft=ion
        endif
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
	endif
endfunction

if line('$') == 1 && getline(1) == ''
    call <SID>shellbang()
endif

command! -bang -nargs=0 -bar ShellBang call <SID>shellbang()
