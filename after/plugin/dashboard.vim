let g:dashboard_custom_header = [
    \ '                                 ,',
    \ '                              ,   ,`|',
    \ '                            ,/|.-`   \.',
    \ '                         .-`  `       |.',
    \ '                   ,  .-`              |',
    \ '                  /|,`                 |`',
    \ '                 / `                    |  ,',
    \ '                /                       ,`/',
    \ '             .  |          _              /',
    \ '              \`` .-.    ,` `.           |',
    \ '               \ /   \ /      \          /',
    \ '                \|    V        |        |  ,',
    \ '                 (           ) /.--.   ``"/',
    \ '                 "b.`. ,` _.ee`` 6)|   ,-`',
    \ '                   \"= --""  )   ` /.-`',
    \ '                    \ / `---"   ."|`',
    \ '                     \"..-    .`  |.',
    \ '                      `-__..-`,`   |',
    \ '                   __.) ` .-`/    /\._',
    \ '              _.--`/----..--------. _.-""-._',
    \ '           .-`_)   \.   /     __..-`     _.-`--.',
    \ '          / -`/      """""""""         ,`-.   . `.',
    \ '         | ` /                        /    `   `. \',
    \ '         |   |                        |         | |',
    \ '          \ . \                       |     \     |',
    \ '         / `  | ,`               . -  \`.    |  / /',
    \ '        / /   | |                      `/"--. -  /\',
    \ '       | |     \ \                     /     \     |',
    \ '       | \      | \                  .-|      |    |'
    \ ]
let quote = systemlist('~/.local/share/nvim/bin/pq')
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