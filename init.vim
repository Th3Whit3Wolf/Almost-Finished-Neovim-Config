lua << EOF
require('init')
EOF

" If sudo, disable vim swap/backup/undo/shada/viminfo writing
if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
		\ && $HOME !=# expand('~'.$USER)
		\ && $HOME ==# expand('~'.$SUDO_USER)

	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
	set shada="NONE"
endif

" <c-k> will either expand the current snippet at the word or try to jump to
" the next position for the snippet.
inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>

" <C-Tab> will jump backwards to the previous field.
" If you jump before the first field, it will cancel the snippet.
inoremap <C-Tab> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

" Allow misspellings
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!

function! MyFoldText()
	let line = getline(v:foldstart)
	let nucolwidth = &fdc + &number * &numberwidth
	let windowwidth = winwidth(0) - nucolwidth - 3
	let foldedlinecount = v:foldend - v:foldstart

	" expand tabs into spaces
	let onetab = strpart('          ', 0, &tabstop)
	let line = substitute(line, '\t', onetab, 'g')

	let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
	let fillcharcount = windowwidth - len(line)
	return line . ''. repeat(" ",fillcharcount)
endfunction

set foldtext=MyFoldText()

function! s:get_highlight()
	let l:gp_nm = synIDattr(synID(line("."), col("."), 1), "name")
	let l:fg = synIDattr(synIDtrans(hlID(l:gp_nm)), "fg#")
	let l:bg = synIDattr(synIDtrans(hlID(l:gp_nm)), "bg#")
	echo "Group(bg,fg): "l:gp_nm"("l:fg","l:bg")"
endfunction

" Get current syntax highlight group for item under cursor
command! GetHighlight call <SID>get_highlight()
