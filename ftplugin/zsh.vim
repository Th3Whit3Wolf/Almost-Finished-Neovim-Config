packadd vim-zsh
packadd zinit-vim-syntax
packadd vim-endwise

let g:endwise_no_mappings = v:true
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

function! RunMyCode()
    if executable('zsh')
        call Run("zsh %")
    else
        echom 'Zsh is not installed!'
    endif
endfunction

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
        elseif choice =! 12
            set ft=sh
        endif
        0put = '#!/usr/bin/env ' . (options)[choice - 1]
	endif
endfunction

command! -bang -nargs=0 -bar ShellBang call <SID>shellbang()