
packadd space-nvim-theme "My spacemacs inspired theme
let hr = str2nr(strftime('%H'))
if strftime("%H") >= g:setcolor_morning_time && strftime("%H") < g:setcolor_night_time
    set background=light
else
    set background=dark
endif

colorscheme space-nvim-theme

" Adapted from WEREWOLF
"" version 1.2.1
"" changes your colorscheme depending on the time of day
"" by Jonathan Stoler

function! Setcolor()
	let current_scheme = get(g:, 'colors_name', 'default')
	if strftime("%H") >= g:setcolor_morning_time && strftime("%H") < g:setcolor_night_time
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
	else
		set background=light
	endif
	luafile ~/.local/share/nvim/site/pack/packer/opt/space-nvim-theme/lua/space-nvim-theme.lua
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

augroup setcolor
	autocmd!
	autocmd ColorScheme * nested call Setcolor()
	autocmd CursorMoved,CursorHold,CursorHoldI,WinEnter,WinLeave,FocusLost,FocusGained,VimResized,ShellCmdPost * nested call setcolor#autoChange()
augroup END