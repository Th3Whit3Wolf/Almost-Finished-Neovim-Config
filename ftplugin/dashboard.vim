lua << END
local global = require 'settings/global'
if not global.exists(os.getenv("HOME") .. '/.cargo/bin/pquote') then
        os.execute("cargo install --git https://github.com/Th3Whit3Wolf/pquote")
    end
END
"""""""""""""""""""""""""""""
" Dashboard Nvim
"""""""""""""""""""""""""""""
let g:dashboard_custom_header = [
        \ '',
        \ '                    ''c.',
        \ '                 ,xNMM.',
        \ '               .OMMMMo',
        \ '               OMMM0,',
        \ '     .;loddo:'' loolloddol;.',
        \ '   cKMMMMMMMMMMNWMMMMMMMMMM0:',
        \ ' .KMMMMMMMMMMMMMMMMMMMMMMMWd.',
        \ ' XMMMMMMMMMMMMMMMMMMMMMMMX.',
        \ ';MMMMMMMMMMMMMMMMMMMMMMMM:',
        \ ':MMMMMMMMMMMMMMMMMMMMMMMM:',
        \ '.MMMMMMMMMMMMMMMMMMMMMMMMX.',
        \ ' kMMMMMMMMMMMMMMMMMMMMMMMMWd.',
        \ ' .XMMMMMMMMMMMMMMMMMMMMMMMMMMk',
        \ '  .XMMMMMMMMMMMMMMMMMMMMMMMMK.',
        \ '    kMMMMMMMMMMMMMMMMMMMMMMd',
        \ '     ;KMMMMMMMWXXWMMMMMMMk.',
        \ '       .cooc,.    .,coo:.',
        \ '',
        \ ]
let quote = systemlist('pquote')
let g:dashboard_custom_footer = quote

let g:dashboard_custom_section={
	\ 'last_session' :[' Open last session                    SPC sl '],
	\ 'find_history' :['ﭯ Recently opened files                SPC fh '],
    \ 'find_file'    :[' Find File                            SPC ff '],
    \ 'find_word'    :[' Find word                            SPC fa '],
    \ 'book_marks'   :[' Jump to book marks                   SPC fb '],
	\ }


function! BOOK_MARKS()
	Clap marks
endfunction

function! FIND_FILE()
	Clap files ++finder=rg --ignore --hidden
endfunction

function! FIND_HISTORY()
	Clap history
endfunction

function! FIND_WORD()
	Clap grep2
endfunction

function! LAST_SESSION()
	SessionLoad
endfunction

set showtabline=0 
autocmd WinLeave <buffer> set showtabline=2