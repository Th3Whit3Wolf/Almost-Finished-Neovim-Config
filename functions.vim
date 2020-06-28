""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds
" FastFold
" Credits: https://github.com/Shougo/shougo-s-github
""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('folding')
	set foldenable
	set foldmethod=syntax
	set foldlevelstart=99
	set foldtext=FoldText()
endif

function! FoldText()
	" Get first non-blank line
	let fs = v:foldstart
	while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = ' ' . foldSize . ' lines '
	let foldLevelStr = repeat('+--', v:foldlevel)
	let lineCount = line('$')
	let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
	let expansionString = repeat('.', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
	return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
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

function! UninstallUnusedCocExtensions() abort
    for e in keys(json_decode(join(readfile(expand('~/.config/coc/extensions/package.json')), "\n"))['dependencies'])
        if index(s:coc_extensions, e) < 0
            execute 'CocUninstall ' . e
        endif
    endfor
endfunction

function! CheckBackSpace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

function! ShowDocumentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
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

let c_flags = "-D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS -fasynchronous-unwind-tables -fexceptions -fpie -Wl,-pie -fpic -shared -fplugin=annobin -fstack-clash-protection -fstack-protector-strong -g -grecord-gcc-switches -mcet -fcf-protection -pipe -Wall -Werror=format-security -Werror=implicit-function-declaration -Wl,-z,defs -Wl,-z,now -Wl,-z,relro"

function CompileMyCode()
    if &modified
		write
	end
		
    if &filetype == 'c'
		if executable('gcc')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 gcc % -o %< " + c_flags
		endif
	elseif &filetype == 'cpp'
		if executable('g++')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 g++ -std=c++17 % -o %< " + c_flags
		endif
	elseif &filetype == 'go'
		if executable('go')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 go build %"
		else
			echo 'Go is not installed!'
		endif
	elseif &filetype == 'haskell'
		if executable('ghc')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 ghc % -o %<"
		else
			echo 'Haskell is not installed!'
		endif
	elseif &filetype == 'java'
		if executable('javac')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 javac %"
		else
			echo 'Java is not installed!'
		endif
	elseif &filetype == 'rust'
		if InCargoProject()
			if executable('cargo') 
				exec "AsyncRun -mode=term -pos=bottom -rows=30 cargo build --release"
			else
				echo 'Cargo is not installed or this is not a cargo project'
			endif
		else
			if executable('rustc')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 rustc % -o %<"
				
			else
				echo 'Rustc is not installed or this is not a cargo project'
			endif
		endif
	else
		echo "Dunno how to run such a file..."
	endif
endfunction

function! RunMyCode()
	
    if &modified
		write
	end
    if &filetype == 'c'
		if executable('gcc')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 gcc % -o %<  " + c_flags +"; ./%<"
		endif
	elseif &filetype == 'cpp'
		if executable('g++')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 g++ -std=c++17 % -o %< " + c_flags +"; ./%<"
		endif
	elseif &filetype == 'rust'
		if InCargoProject()
			if executable('cargo') 
				exec "AsyncRun -mode=term -pos=bottom -rows=30 cargo run"				
			else
				echo 'Cargo is not installed or this is not a cargo project'
			endif
		else
			if executable('rustc')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 rustc % -o %<; ./%<"				
			else
				echo 'Rustc is not installed or this is not a cargo project'
			endif
		endif
	elseif &filetype == 'html'
		let g:bracey_refresh_on_save = 1
		Bracey
	elseif &filetype == 'markdown'
		ComposerOpen
		ComposerUpdate
	elseif &filetype == 'java'
		if executable('javac')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 javac %"			
		else
			echo 'Java is not installed!'
		endif
	elseif &filetype == 'sh'
		if getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash"
			if executable('bash')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 bash %"				
			else
				echo 'Bash is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash"
			if executable('dash')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 dash %"				
			else
				echo 'Dash is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env fish" || getline(1)[0:14] ==# "#!/usr/bin/fish"
			if executable('fish')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 fish %"				
			else
				echo 'Fish is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh"
			if executable('tcsh')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 tcsh %"				
			else
				echo 'Tcsh is not installed!'
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh"
			if executable('csh')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 csh %"				
			else
				echo 'Csh is not installed!'
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh"
			if executable('ksh')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 ksh %"				
			else
				echo 'Ksh is not installed!'
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env zsh" || getline(1)[0:13] ==# "#!/usr/bin/zsh"
			if executable('zsh')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 zsh %"				
			else
				echo 'Zsh is not installed!'
			endif
		endif
	elseif &filetype == 'python'
		if getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3"
			if executable('python3')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 python3 %"				
			else
				echo 'Python3 is not installed!'
			endif
		elseif getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2"
			if executable('python2')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 python2 %"				
			else
				echo 'Python2 is not installed!'
			endif
		elseif getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python"
			if executable('python')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 python %"				
			else
				echo 'Python executable can not be found!'
			endif
		elseif getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3"
			if executable('pypy3')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 pypy3 %"				
			else
				echo 'Pypy3 is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy"
			if executable('pypy')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 pypy %"				
			else
				echo 'Pypy is not installed!'
			endif
		elseif getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython"
			if executable('jython')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 jython %"				
			else
				echo 'Jython is not installed!'
			endif
		endif
	elseif &filetype == 'go'
		if executable('go')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 go run %"			
		else
			echo 'Go is not installed!'
		endif
	elseif &filetype == 'haskell'
		if executable('ghc')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 ghc % -o %<"			
		else
			echo 'Haskell is not installed!'
		endif
	elseif &filetype == 'javascript'
		if executable('node')
			exec "AsyncRun -mode=term -pos=bottom -rows=30 node %"			
		else
			echo 'Node is not installed!'
		endif
	elseif &filetype == 'ruby'
		if InRailsApp()
			if executable('ruby')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 rails runner %"
			else
				echo 'Rails is not installed!'
			endif
		else
			if executable('ruby')
				exec "AsyncRun -mode=term -pos=bottom -rows=30 ruby %"
			else
				echo 'Ruby is not installed!'
			endif
		endif
	else
		echo "Dunno how to run such a file..."
	endif
endfunction

function! RunRustTest()
	if &modified
		write
	end
	
	if executable('cargo')
		AsyncRun -mode=term -pos=bottom -rows=30 cargo test --all -- --test-threads=1
	else
		echo 'Rust is not installed or this is not a cargo project'
	endif
endfunction

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
		exec ':saveas ' . new_name
		exec ':silent !rm ' . old_name
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

function! InCargoProject(...)
	if filereadable("Cargo.toml")
		return 1
	elseif filereadable("../Cargo.toml")
		return 1
	elseif filereadable("../../Cargo.toml")
		return 1
	elseif filereadable("../../Cargo.toml")
		return 1
	else
		return 0
endfunction

function! InRailsApp(...)
	return filereadable("app/controllers/application_controller.rb")
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

function! SearchForSelectedWord()
	let word = GetVisualSelection()
	tabedit
	execute "Rg " . word
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

"""""""""""""""""""""""""""""
" Dashboard Nvim
"""""""""""""""""""""""""""""
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

