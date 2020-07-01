"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shebang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:shell_shebang()
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

    let choice = inputlist([ 'Select your shell:' ]
        \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(options)) - 2)
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
	endif
endfunction

function! s:python_shebang()
	if getline(1)[0:1] !=# "#!"
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
	endif
endfunction

" Autoprompt Add Shebang
if has("autocmd")
 	autocmd BufNewFile *.escript 0put =\"#!/usr/bin/env escript"
 	autocmd BufNewFile *.fish    0put =\"#!/usr/bin/env fish"
 	autocmd BufNewFile *.ion     0put =\"#!/usr/bin/env ion"
 	autocmd BufNewFile *.lua     0put =\"#!/usr/bin/env lua"
    autocmd BufNewFile *.pl      0put =\"#!/usr/bin/env perl"
	autocmd BufNewFile *.php     0put =\"#!/usr/bin/env php
    autocmd BufNewFile *.py      call <SID>python_shebang()
    autocmd BufNewFile *.rb      0put =\"#!/usr/bin/env ruby"
	autocmd BufNewFile *.sh      call <SID>shell_shebang()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Change Shebang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap  <buffer> <leader>ccs :call <SID>change_bang()<CR>
function! s:change_bang()
	if &filetype == 'shell'
        if getline(1)[0:1] !=# "#!"
            let shell_options  = [
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

            let choice = inputlist([ 'Select your shell:' ]
                \ + map(copy(shell_options), '"[".(v:key+1)."] ".v:val'))

            if choice >= 1 && choice <= (len(copy(shell_options)) - 2)
                1d
                0put = '#!/usr/bin/env ' . (shell_options)[choice - 1]
            endif
        endif
	elseif &filetype == 'python'
        if getline(1)[0:1] !=# "#!"

        let python_options  = [
            \ 'python2',
            \ 'python3',
            \ 'pypy',
            \ 'pypy3',
            \ 'jython',
            \ 'none'
            \ ]

        let choice = inputlist([ 'Select your shell:' ]
            \ + map(copy(python_options), '"[".(v:key+1)."] ".v:val'))

        if choice >= 1 && choice <= (len(copy(python_options)) - 2)
                1d
                0put = '#!/usr/bin/env ' . (python_options)[choice - 1]
        endif
    else
        echom "I don't know how to handle this filetype"
    endif
endfunction