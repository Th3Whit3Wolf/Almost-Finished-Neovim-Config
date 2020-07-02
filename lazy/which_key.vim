" Define prefix dictionary

let g:which_key_map =  {
	\ 'name' : 'Space'                          ,
	\ '1'    : 'Switch to Buffer 1'             ,
	\ '2'    : 'Switch to Buffer 2'             ,
	\ '3'    : 'Switch to Buffer 3'             ,
	\ '4'    : 'Switch to Buffer 4'             ,
	\ '5'    : 'Switch to Buffer 5'             ,
	\ '6'    : 'Switch to Buffer 6'             ,
	\ '7'    : 'Switch to Buffer 7'             ,
	\ '8'    : 'Switch to Buffer 8'             ,
	\ '9'    : 'Switch to Buffer 9'             ,
	\ '0'    : 'Switch to Buffer 10'            ,
	\ 'a'    : 'Copy All'                       ,
	\ 'b'    : 'Search Buffers'                 ,
	\ 'h'    : 'Horizontal Split'               ,
	\ 'i'    : 'Indent All'                     ,
	\ 'j'    : 'Coc Action Next'                , 
	\ 'J'    : 'Goto Definition'                ,
	\ 'k'    : 'Coc Action Previous'            ,
	\ 'p'    : 'Paste From System Clipboard'    , 
	\ 'q'    : 'Exit Split'                     ,
	\ 'v'    : 'Vertical Split'                 ,
	\ 'w'    : 'Write and Quit'                 ,
	\ 'y'    : 'Yank Relative Path'             ,
	\ 'Y'    : 'Yank Absolute Path'             ,
	\ 'z'    : 'Correct Spelling'               ,
	\ 'F2'   : 'Rename File'                    ,
	\ }

let g:which_key_map['c'] = {
	\ 'name' : '+Code'                        ,
	\ 'a'    : {
	\    'name': '+CodeAction'                , 
	\    'b'   : 'Current Buffer'             ,
	\    's'   : 'Selected Region'            ,
	\ }                                       ,
	\ 'cs'   : 'Code Change Shebang'          ,
	\ 'l' : {
	\    'name': '+CocList'                   ,
	\    'a'  : 'Code Lens Action'           ,
	\    'c'  : 'CocList Commands'           ,
	\    'd'  : 'CocList Diagnostics'        ,
	\    'e'  : 'CocList Extensions'         ,
	\    'o'  : 'CocList Outline'            ,
	\    'r'  : 'CocList Resume'             ,
	\    's'  : 'CocList Symbols'            ,
	\ }                                       ,
	\ 'f'    : 'Format Selected Code'         ,
	\ 'q' : {
	\    'name': '+QuickFix'                  ,
	\    'f' : 'Fix Problem on Current Line' ,
	\ }                                       ,
	\ 'rn'   : 'Rename Symbols '              ,
	\ }

let g:which_key_map['f'] = {
	\ 'name' : '+Find'     ,
	\ 'a'    : 'Find Word' ,
	\ 'b'    : 'Bookmarks' ,
	\ 'f'    : 'Find File' ,
	\ 'l'    : 'Find Line' ,
	\ 'h'    : 'History'   ,
	\ }

let g:which_key_map['m'] = {
	\ 'name' : '+Markdown'                ,
	\ 'd'    : 'Set Filetype as Markdown' ,
	\ 'h'    : 'Heading 1'       ,
	\ 'H'    : 'Heading 2'       ,
	\ }

let g:which_key_map['s'] = {
	\ 'name' : '+Session'     ,
	\ 'l'    : 'Session Load' ,
	\ 's'    : 'Session Save' ,
	\ }

let g:which_key_map['t'] = {
	\ 'name' : '+Toggle'          ,
	\ 'f'    : 'Toggle File Tree' ,
	\ 't'    : 'Toggle Terminal'  ,
	\ 'v'    : 'Toggle Vista'
	\ }

let g:which_key_sep = '=>'

function! s:WhichKeyCodeTest()
	nnoremap <buffer> <leader>cc :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call CompileMyCode()<CR>
    nnoremap <buffer> <leader>cr :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call RunMyCode()<CR>
    nnoremap <buffer> <leader>ct :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call RunRustTest()<CR>
	let g:which_key_map.c.c = 'Code Compile'
	let g:which_key_map.c.r = 'Code Run'
	let g:which_key_map.c.t = 'Code Test'
endfunction

function! s:WhichKeyCodeCompileRun()
	nnoremap <buffer> <leader>cc :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call CompileMyCode()<CR>
    nnoremap <buffer> <leader>cr :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call RunMyCode()<CR>
	let g:which_key_map.c.c = 'Code Compile'
	let g:which_key_map.c.r = 'Code Run'
	if has_key(g:which_key_map.c, 't')
		unlet g:which_key_map.c.t
	endif
endfunction

function! s:WhichKeyCodeCompile()
	nnoremap <buffer> <leader>cc :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call CompileMyCode()<CR>
	let g:which_key_map.c.c = 'Code Compile'
	if has_key(g:which_key_map.c, 'r')
		unlet g:which_key_map.c.r
	endif
	if has_key(g:which_key_map.c, 't')
		unlet g:which_key_map.c.t
	endif
endfunction

function! s:WhichKeyCodeRun()
    nnoremap <buffer> <leader>cr :packadd asyncrun.vim <bar> let g:asyncrun_last = 1 <bar> call RunMyCode()<CR>
	let g:which_key_map.c.r = 'Code Run'
	if has_key(g:which_key_map.c, 'c')
		unlet g:which_key_map.c.c
	endif
	if has_key(g:which_key_map.c, 't')
		unlet g:which_key_map.c.t
	endif
endfunction

function! s:WhichKeyCodeNone()
	if has_key(g:which_key_map.c, 'c')
		unlet g:which_key_map.c.c
	endif
	if has_key(g:which_key_map.c, 'r')
		unlet g:which_key_map.c.r
	endif
	if has_key(g:which_key_map.c, 't')
		unlet g:which_key_map.c.t
	endif
endfunction

function s:SetKeyOnFT()
	if &ft == 'c' || &ft == 'cpp'
		if executable('gcc') 
			call s:WhichKeyCodeCompileRun()
		else
			call s:WhichKeyCodeNone()
		endif
	elseif &ft == 'go'
		if executable('go')
			call s:WhichKeyCodeCompileRun()
		else
			call s:WhichKeyCodeNone()
		endif
	elseif &ft == 'haskell'
		if executable('ghc')
			call s:WhichKeyCodeCompileRun()
		else
			call s:WhichKeyCodeNone()
		endif
	elseif &ft == 'html'
		call s:WhichKeyCodeRun()
	elseif &ft == 'java'
		if executable('javac')
			call s:WhichKeyCodeCompileRun()
		else
			call s:WhichKeyCodeNone()
		endif
	elseif &ft == 'javascript'
		if executable('node')
			call s:WhichKeyCodeRun()
		else
			call s:WhichKeyCodeNone()
		endif
	elseif &ft == 'markdown'
		call s:WhichKeyCodeRun()
	elseif &ft == 'python'
		if getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3"
			if executable('python3')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2"
			if executable('python2')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python"
			if executable('python')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3"
			if executable('pypy3')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy"
			if executable('pypy')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython"
			if executable('jython')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		endif
	elseif &ft == 'ruby'
		if filereadable("app/controllers/application_controller.rb")
			if executable('rails')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		else
			if executable('ruby)
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		endif
	elseif &ft == 'rust'
		if InCargoProject()
			if executable('cargo')
				call s:WhichKeyCodeTest()
			else
				call s:WhichKeyCodeNone()
			endif
		else
			if executable('rustc')
				call s:WhichKeyCodeCompileRun()
			else
				call s:WhichKeyCodeNone()
			endif
		endif
	elseif &ft == 'sh'
		if getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash"
			if executable('bash')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash"
			if executable('dash')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env fish" || getline(1)[0:14] ==# "#!/usr/bin/fish"
			if executable('fish')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh"
			if executable('tcsh')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh"
			if executable('csh')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh"
			if executable('ksh')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env zsh" || getline(1)[0:13] ==# "#!/usr/bin/zsh"
			if executable('zsh')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		endif
	else
		call s:WhichKeyCodeNone()
	endif
endfunction

function! s:SetKeyOnGit()
	let git_dir = system('git rev-parse --git-dir')
	" if in a git repo
	if !v:shell_error
		let g:which_key_map_git = {'name': '+git'}
		let g:which_key_map_git.m = 'Messenger'
		nmap  <silent> <leader>gm :if !exists('g:git_messenger_git_command') <bar> :packadd git-messenger.vim <bar>: call VimWhichGM() <bar> :endif <bar><CR> <Plug>(git-messenger)

		function! VimWhichGM()
			let g:git_messenger_no_default_mappings = v:true
		endfunction

		if executable('lazygit')
			let g:which_key_map_git.l = 'Lazy'
			nnoremap <silent> <leader>gl :call OpenLazyGit()<CR>
		endif
		let g:which_key_map.g = g:which_key_map_git
	elseif has_key(g:which_key_map, 'g')
		unlet g:which_key_map.g
	endif
endfunction

call s:SetKeyOnFT()
call s:SetKeyOnGit()

function! SetWhichKey() abort
	call s:SetKeyOnGit()
	call s:SetKeyOnFT()
endfunction

autocmd BufEnter * call SetWhichKey()
