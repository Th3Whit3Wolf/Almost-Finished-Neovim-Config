function! LazySource(path, ...) abort
	let abspath = resolve(expand($VIMPATH.'/lazy/'.a:path.'.vim'))
	if !stridx(&rtp, abspath) == 0
		execute 'source' fnameescape(abspath)
		return
	endif
endfunction

function! InCargoProject(...)
	return filereadable("Cargo.toml") || filereadable("../Cargo.toml") || filereadable("../../Cargo.toml") || filereadable("../../../Cargo.toml")
endfunction

function! InRailsApp(...)
	return filereadable("app/controllers/application_controller.rb")
endfunction

function! Run(executor)
  packadd asyncrun.vim
  let g:asyncrun_last = 1
  exec "AsyncRun -mode=term -pos=bottom -rows=30 -post=echo\ " . g:asyncrun_name . " " . a:executor

endfunction

let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

function! WipeHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
endfunction

function! s:BufferEmpty()
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction

function! s:SweepBuffers()
	let bufs = range(1, bufnr('$'))
	let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
	if ! empty(hidden)
		execute 'silent bdelete' join(hidden)
	endif
endfunction

" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
function! OpenChangedFiles()
	only " Close all windows, unless they're modified
	let status =
		\ system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
	let filenames = split(status, "\n")
	exec 'edit ' . filenames[0]
	for filename in filenames[1:]
		exec 'sp ' . filename
	endfor
endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

" Creates a floating window with a most recent buffer to be used
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Pmenu
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
if executable('lazygit')
	function! OpenTerm(cmd)
		call CreateCenteredFloatingWindow()
		call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
	endfunction

	function! OpenLazyGit()
		call OpenTerm('lazygit')
		startinsert
	endfunction

	function! OnTermExit(job_id, code, event) dict
		if a:code == 0
			bd!
		endif
	endfunction
endif

function! FixFormatting()
	%s/\r\(\n\)/\1/eg
	retab
	%s/\s\+$//e
	nohlsearch
endfunction

function! FormatSmlComments()
	normal ^
	s/(\*/ */g
	normal gv
	s/ \*)//g
	normal A *)
	normal gvo
	normal r(gvo
	nohlsearch
endfunction

function! YankWholeBuffer(to_system_clipboard)
	if a:to_system_clipboard
		normal maggVG"*y`a
	else
		normal maggyG`a
	endif
endfunction

function! PasteMarkdownLink()
	let link = system("markdown_link " . s:get_visual_selection())
	execute "normal! gvs" . link
endfunction

function! MakeMarkdownHeading(level)
	if a:level == 1
		normal! yypVr=k
	elseif a:level == 2
		normal! yypVr-k
	endif
endfunction

function! ToggleRubyBlockSyntax()
	if match(getline('.'), "do") != -1
		execute "normal! ^/do\<cr>ciw{ "
		execute "normal! lxma"
		execute "normal! jjdd`aJA }"
	else
		execute "normal! ^f{sdo"
		execute "normal! /\|\<cr>nli\<cr>"
		execute "normal! $xxoend"
		execute "normal! kk"
	end
endfunction

function! RenameFile()
	let old_name = expand('%')
	let new_name = input('New file name: ', expand('%'), 'file')
	if new_name != '' && new_name != old_name
		Rename new_name
		redraw!
	endif
endfunction

function! CorrectSpelling()
	normal ma
	let word_before_correction = expand("<cword>")
	let original_setting = &spell

	set spell
	normal 1z=

	let word_after_correction = expand("<cword>")

	if tolower(word_after_correction) == word_before_correction
		undo
	endif

	normal `a
	let &spell = original_setting
endfunction

function! PasteFromSystemClipBoard()
	let os = system("uname")
	if os == "Linux"
		read !xclip -selection clipboard -out
	else
		execute "normal! \<esc>o\<esc>\"+]p"
	end
endfunction

function! RemoveFancyCharacters()
	let typo = {}
	let typo["“"] = '"'
	let typo["”"] = '"'
	let typo["‘"] = "'"
	let typo["’"] = "'"
	let typo["–"] = '--'
	let typo["—"] = '---'
	let typo["…"] = '...'
	:exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction

function! MakeList()
	s/^/\=(line('.')-line("'<")+1).'. '"'"))
endfunction

function! SetIndentation(level)
	let &shiftwidth=a:level
	let &softtabstop=a:level
endfunction

function! CloseExtraPane()
	if &filetype == "gundo"
		execute ":GundoToggle"
	else
		execute ":cclose"
		execute ":pclose"
	end
endfunction

function! s:get_visual_selection()
	" Why is this not a built-in Vim script function?!
	let [line_start, column_start] = getpos("'<")[1:2]
	let [line_end, column_end] = getpos("'>")[1:2]
	let lines = getline(line_start, line_end)
	if len(lines) == 0
		return ''
	endif
	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][column_start - 1:]
	return join(lines, "\n")
endfunction

function! CtrlPCurrentDir()
	let pwd = getcwd()
	execute "Clap files " . pwd
endfunction

function! GetVisualSelection()
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][col1 - 1:]
	return join(lines, "\n")
endfunction

function! FormatSql()
	let path = expand('%:p')
	write
	execute "silent !format-sql \"" . path . "\""
	edit
endfunction

"function! RunSqlQuery()
"	let path = expand('%:p')
"	write
"	new
"	setlocal buftype=nofile
"	setlocal bufhidden=hide
"	setlocal noswapfile
"	setlocal nowrap
"	execute "read !psql " . $TONSSER_PRODUCTION_DATABASE . " -f " . path
"	call FixFormatting()
"endfunction


function! Changebang()
	if &ft == 'sh' || &ft == 'fish' || &ft == 'ion'
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

        unsilent let choice = inputlist([ 'Select your shell:' ]
            \ + map(copy(shell_options), '"[".(v:key+1)."] ".v:val'))

        if choice >= 1 && choice <= (len(copy(shell_options)) - 2)
            1d
            0put = '#!/usr/bin/env ' . (shell_options)[choice - 1]

        endif
	elseif &filetype == 'python'
        let python_options  = [
            \ 'python2',
            \ 'python3',
            \ 'pypy',
            \ 'pypy3',
            \ 'jython',
            \ 'none'
            \ ]

        unsilent let choice = inputlist([ 'Select your shell:' ]
            \ + map(copy(python_options), '"[".(v:key+1)."] ".v:val'))

        if choice >= 1 && choice <= (len(copy(python_options)) - 2)
                1d
                0put = '#!/usr/bin/env ' . (python_options)[choice - 1]
        endif
    else
        echom "I don't know how to handle this filetype"
    endif
endfunction

command! -bang -nargs=0 -bar ChangeBang call Changebang()
