function! s:pybang()
    let options  = [
        \ 'python2',
        \ 'python3',
        \ 'pypy',
        \ 'pypy3',
        \ 'jython',
        \ 'none'
        \ ]

    let choice = inputlist([ 'Select your shell:' ]
        \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(options)) - 2)
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
	endif
endfunction

if line('$') == 1 && getline(1) == ''
    call <SID>pybang()
endif

command! -bang -nargs=0 -bar PyBang call <SID>pybang()
