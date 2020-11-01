hi link DashboardHeader String
hi link DashboardCenter Macro
hi link DashboardShortcut PreProc
hi link DashboardFooter Type

let g:dashboard_executive ='telescope'

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
    \ '       | \      | \                  .-|      |    |',
    \ '',
    \ '             [ Dashboard version : '. g:dashboard_version .' ]     ',
    \ ]

let g:dashboard_custom_section={
	\ 'last_session' :{
        \ 'description': ['    Open last session                       SPC sl   '],
        \ 'command':function('dashboard#handler#last_session')},
    \ 'find_history' :{
        \ 'description': ['   ﭯ Recently opened files                   SPC fh   '],
        \ 'command':function('dashboard#handler#find_history')},
    \ 'find_file'    :{
        \ 'description': ['    Find File                               SPC ff   '],
        \ 'command':function('dashboard#handler#find_file')},
    \ 'find_word'    :{
        \ 'description': ['    Find word                               SPC fw   '],
        \ 'command': function('dashboard#handler#find_word')},
    \ 'book_marks'   :{
        \ 'description': ['    Jump to book marks                      SPC fm   '],
        \ 'command':function('dashboard#handler#book_marks')},
    \ }

lua << EOF
function loadedPlugins()
    local count = 0
    paths = {};
    for match in (package.path..';'):gmatch("(.-)"..';') do
        table.insert(paths, match);
    end
    for k,_ in pairs(paths) do
        if string.match(paths[k], "nvim/site/pack/") then
        count = count + 1
        end
    end
    return count
end

EOF
let loaded_plugins = v:lua.loadedPlugins()

" we ignore the directories 'start' and 'opt'
let total_plugins = trim(system("fd -d 2 . $HOME'/.local/share/nvim/site/pack/packer' | head -n -2 | wc -l"))
let quote = systemlist("~/.local/share/nvim/bin/pq")

let g:dashboard_custom_footer = ["                            loaded " . loaded_plugins . " of " . total_plugins ." plugins     "]  + [""] + quote

set showtabline=0 
autocmd WinLeave <buffer> set showtabline=2
