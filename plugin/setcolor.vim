let g:light_theme = 'one'
let g:dark_theme = 'onedark'
let g:morning = 7
let g:night = 19
let g:setcolor_change_automatically = 1
let s:setcolor_autocmd_allowed = 0

let hr = str2nr(strftime('%H'))
if strftime("%H") >= g:morning && strftime("%H") < g:night
    set background=light
else
    set background=dark
endif

colorscheme one
hi Normal guibg=NONE ctermbg=NONE

" Cargo.toml
highlight link Crates Comment

" Adapted from WEREWOLF
"" version 1.2.1
"" changes your colorscheme depending on the time of day
"" by Jonathan Stoler

function! Setcolor()
	let current_scheme = get(g:, 'colors_name', 'default')
	if strftime("%H") >= g:morning && strftime("%H") < g:night
		if &background == "dark"
			call setcolor#ChangeColo()
		endif
	else
		if &background == "light"
			call setcolor#ChangeColo()
		endif
	endif
endfunction

function! setcolor#ChangeColo()
	if &background == "light"
		set background=dark
		colorscheme one
	else
		set background=light
		colorscheme one
	endif
	" if we don't do this check, Setcolor's own ColorScheme autocmd will
	" run infinitely; this limits when it happens
	if s:setcolor_autocmd_allowed
		doau ColorScheme AutoColor
		let s:setcolor_autocmd_allowed = 0
	endif
	return
endfunction

function! ColorToggle()
	call setcolor#colorschemeChanged()
endfunction

function! setcolor#colorschemeChanged()
	let s:setcolor_autocmd_allowed = 0
	call setcolor#ChangeColo()
endfunction

function! setcolor#autoChange()
	if g:setcolor_change_automatically
		let s:setcolor_autocmd_allowed = 1
		call Setcolor()
	endif
endfunction

command! ColorToggle call ColorToggle()

augroup setcolor
	autocmd!
	autocmd ColorScheme * nested call Setcolor()
	autocmd CursorMoved,CursorHold,CursorHoldI,WinEnter,WinLeave,FocusLost,FocusGained,VimResized,ShellCmdPost * nested call setcolor#autoChange()
	autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
augroup END