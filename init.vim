syntax enable
filetype plugin indent on

lua << EOF
require('init')
EOF


packadd space-nvim-theme "My spacemacs inspired theme

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

" Disable swap/undo/viminfo/shada files in temp directories or shm
augroup user_secure
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
		\ setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada=
augroup END

" <c-k> will either expand the current snippet at the word or try to jump to
" the next position for the snippet.
inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>

" <c-j> will jump backwards to the previous field.
" If you jump before the first field, it will cancel the snippet.
inoremap <c-j> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

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

function! GetHighlight()
	let l:gp_nm = synIDattr(synID(line("."), col("."), 1), "name")
  	let l:fg = synIDattr(synIDtrans(hlID(l:gp_nm)), "fg#")
  	let l:bg = synIDattr(synIDtrans(hlID(l:gp_nm)), "bg#")
	echo "Group(bg,fg): "l:gp_nm"("l:fg","l:bg")"
endfunction

call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "ஐ", "texthl" : "LspDiagnosticsHint"})

command! PlugInstall execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').install()
command! PlugUpdate  execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').update()
command! PlugSync    execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').sync()
command! PlugClean   execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').clean()
command! PlugCompile execute 'luafile ' . stdpath('config') . '/lua/plug.lua' | packadd packer.nvim | lua require('plug').compile()

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['<', '>']]

hi link Crates Comment

" Normal color in popup window with 'CursorLine'
hi link gitmessengerPopupNormal CursorLine

" Header such as 'Commit:', 'Author:' with 'Statement' highlight group
hi link gitmessengerHeader CursorLine

" Commit hash at 'Commit:' header with 'Special' highlight group
hi link gitmessengerHash CursorLine

" History number at 'History:' header with 'Title' highlight group
hi link gitmessengerHistory CursorLine

let g:clap_layout = { 'relative': 'editor' }
let g:clap_current_selection_sign= { 'text': '●', 'texthl': "StatusLineNC", "linehl": "PmenuSel"}
let g:clap_spinner_frames = ['⠋', '⠙', '⠚', '⠞', '⠖', '⠦', '⠴', '⠲', '⠳', '⠓']
" A funtion to config highlight of ClapSymbol
" when the background color is opactiy
function! s:ClapSymbolHL() abort
	let s:current_bgcolor = synIDattr(hlID("Normal"), "bg")
	if s:current_bgcolor == ''
		hi ClapSymbol guibg=NONE ctermbg=NONE
	endif
endfunction

autocmd User ClaqpOnEnter call s:ClapSymbolHL()

if has('nvim') && executable('nvr')
	let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif


command! LazyGit lua require'myplugins/lazygit'.lazygit()
command! LazyGitFilter lua require'myplugins/lazygit'.lazygitfilter()
command! LazyGitConfig lua require'myplugins/lazygit'.lazygitconfig()