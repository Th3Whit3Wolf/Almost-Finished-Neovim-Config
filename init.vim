syntax enable
filetype plugin indent on
" set background=light

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

" Commands to install plugins
command! -nargs=* InstallPlug :lua plug.install( '<args>' )

function! GetHighlight()
	let l:gp_nm = synIDattr(synID(line("."), col("."), 1), "name")
  	let l:fg = synIDattr(synIDtrans(hlID(l:gp_nm)), "fg#")
  	let l:bg = synIDattr(synIDtrans(hlID(l:gp_nm)), "bg#")
	echo "Group(bg,fg): "l:gp_nm"("l:fg","l:bg")"
endfunction

highlight link Crates Comment
call sign_define("LspDiagnosticsErrorSign", {"text" : "✘", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "ஐ", "texthl" : "LspDiagnosticsHint"})

execute 'luafile ' . stdpath('config') . '/lua/plug.lua'
command! PlugInstall packadd packer.nvim | lua require('plug').install()
command! PlugUpdate packadd packer.nvim | lua require('plug').update()
command! PlugSync packadd packer.nvim | lua require('plug').sync()
command! PlugClean packadd packer.nvim | lua require('plug').clean()
command! PlugCompile packadd packer.nvim | lua require('plug').compile()