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
	\ 'i'    : 'Indent All'                     ,
	\ 'j'    : 'Goto Definition in Split'       ,
	\ 'p'    : 'Paste From System Clipboard'    ,
	\ 'q'    : 'Exit Split'                     ,
	\ 'y'    : 'Yank Relative Path'             ,
	\ 'Y'    : 'Yank Absolute Path'             ,
	\ 'z'    : 'Correct Spelling'               ,
	\ 'F2'   : 'Rename File'                    ,
	\ }

let g:which_key_map['c'] = {
	\ 'name' : '+Code'                       ,
	\ 'a'    : {
	\    'name': '+CodeAction'               ,
	\    'b'   : 'Current Buffer'            ,
	\    's'   : 'Selected Region'           ,
	\ }                                      ,
	\ 'cs'   : 'Code Change Shebang'         ,
	\ 'f'    : 'Format Selected Code'        ,
	\ 'j'    : 'Coc Default Action Next'     ,
	\ 'k'    : 'Coc Default Action Prev'     ,
	\ 'l' : {
	\    'name': '+CocList'                  ,
	\    'a'  : 'Code Lens Action'           ,
	\    'c'  : 'CocList Commands'           ,
	\    'd'  : 'CocList Diagnostics'        ,
	\    'e'  : 'CocList Extensions'         ,
	\    'o'  : 'CocList Outline'            ,
	\    'r'  : 'CocList Resume'             ,
	\    's'  : 'CocList Symbols'            ,
	\ }                                      ,
	\ 'q' : {
	\    'name': '+QuickFix'                  ,
	\    'f' : 'Fix Problem on Current Line'  ,
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
	\ 'h'    : 'Heading 1'                ,
	\ 'H'    : 'Heading 2'                ,
	\ }

let g:which_key_map['s'] = {
	\ 'name' : '+Session/Split'     ,
	\ 'h'    : 'Split Horizontally' ,
	\ 'l'    : 'Session Load'       ,
	\ 's'    : 'Session Save'       ,
	\ 'v'    : 'Split Vertically'   ,
	\ }

let g:which_key_map['t'] = {
	\ 'name' : '+Toggle'    ,
	\ 'f'    : 'File Tree'  ,
	\ 'l'    : 'Lists'      ,
	\ 'n'    : 'Numbers'    ,
	\ 's'    : 'Spelling'   ,
	\ 't'    : 'Terminal'   ,
	\ 'v'    : 'Vista'      ,
	\ 'w'    : 'wrap(smart)',
	\ }

let g:which_key_sep = '=>'

function! s:WhichKeyCodeTest()
	nnoremap <buffer> <leader>cc :update <bar> call CompileMyCode()<CR>
    nnoremap <buffer> <leader>cr :update <bar> call RunMyCode()<CR>
    nnoremap <buffer> <leader>ct :update <bar> call TestMyCode()<CR>
	let g:which_key_map.c.c = 'Code Compile'
	let g:which_key_map.c.r = 'Code Run'
	let g:which_key_map.c.t = 'Code Test'
endfunction

function! s:WhichKeyCodeCompileRun()
	nnoremap <buffer> <leader>cc :update <bar> call CompileMyCode()<CR><ESC>
    nnoremap <buffer> <leader>cr :update <bar> call RunMyCode()<CR><ESC>
	let g:which_key_map.c.c = 'Code Compile'
	let g:which_key_map.c.r = 'Code Run'
	if has_key(g:which_key_map.c, 't')
		unlet g:which_key_map.c.t
	endif
endfunction

function! s:WhichKeyCodeCompile()
	nnoremap <buffer> <leader>cc :update <bar> call CompileMyCode()<CR><ESC>
	let g:which_key_map.c.c = 'Code Compile'
	if has_key(g:which_key_map.c, 'r')
		unlet g:which_key_map.c.r
	endif
	if has_key(g:which_key_map.c, 't')
		unlet g:which_key_map.c.t
	endif
endfunction

function! s:WhichKeyCodeRun()
    nnoremap <buffer> <leader>cr :update <bar> call RunMyCode()<CR><ESC>
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

let g:CompileRunList = [
	\ 'c','cpp','go', 'haskell', 'javac'
	\ ]
let g:RunList        = [
	\ 'fish', 'html', 'ion', 'javascript',
	\ 'mardown', 'python', 'sh'
	\ ]
let g:CompileList     = [
	\ 'coffee','less'
	\ ]

function s:SetKeyOnFT()
	if index(g:CompileRunList, &ft) > -1
		call s:WhichKeyCodeCompileRun()
	elseif index(g:RunList, &ft) > -1
		call s:WhichKeyCodeRun()
	elseif index(g:CompileList, &ft) > -1
		call s:WhichKeyCodeCompile()
	elseif &ft == 'ruby'
		if filereadable("app/controllers/application_controller.rb")
			if executable('rails')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		else
			if executable('ruby')
				call s:WhichKeyCodeRun()
			else
				call s:WhichKeyCodeNone()
			endif
		endif
	elseif &ft == 'rust'
		if filereadable("Cargo.toml") || filereadable("../Cargo.toml") || filereadable("../../Cargo.toml") || filereadable("../../../Cargo.toml")
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
	else
		call s:WhichKeyCodeNone()
	endif
endfunction

function! s:SetKeyOnGitOrProse()
	let git_dir = system('git rev-parse --git-dir')
	" if in a git repo
	if !v:shell_error
		call LazySource('signify')
		call LazySource('git')
		let g:which_key_map_git = {'name': '+git'}
		let g:which_key_map_git.m = 'Messenger'

		if executable('lazygit')
			let g:which_key_map_git.l = 'Lazy'
			nnoremap <silent> <leader>gl :call OpenLazyGit()<CR>
		endif

		let g:which_key_map.g = g:which_key_map_git
		let g:which_key_map['l'] = {
				\ 'name' : '+Lexical'   ,
				\ 'd'    : 'Dictionary' ,
				\ 't'    : 'Thesaurus'  ,
				\ }
	elseif &ft == 'asciidoc' || &ft == 'html' || &ft == 'mail' || &ft == 'markdown' || &ft == 'rst' || &ft == 'tex' || &ft == 'text' || &ft == 'textile' || &ft == 'xml'
		let g:which_key_map['l'] = {
				\ 'name' : '+Lexical'   ,
				\ 'd'    : 'Dictionary' ,
				\ 't'    : 'Thesaurus'  ,
				\ }
	elseif has_key(g:which_key_map, 'g')
		unlet g:which_key_map.g
		unlet g:which_key_map.l
	endif
endfunction

call s:SetKeyOnFT()
call s:SetKeyOnGitOrProse()

function! SetWhichKey() abort
	call s:SetKeyOnGitOrProse()
	call s:SetKeyOnFT()
endfunction

autocmd BufEnter * call SetWhichKey()
