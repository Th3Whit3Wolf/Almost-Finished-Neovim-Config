if &compatible
	set nocompatible
endif

let g:polyglot_disabled = ['rust']
let mapleader = "\<Space>"

" Set main configuration directory, and where cache is stored.
let $VIMPATH = 
	\ expand(($XDG_CONFIG_HOME ? $XDG_CONFIG_HOME : '~/.config') . '/nvim')
" Set data/cache directory as $XDG_CACHE_HOME/vim
let $DATA_PATH =
	\ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache') . '/vim')

if isdirectory($DATA_PATH . '/venv/neovim2')
	let g:python_host_prog = $DATA_PATH . '/venv/neovim2/bin/python'
endif

if isdirectory($DATA_PATH . '/venv/neovim3')
	let g:python3_host_prog = $DATA_PATH . '/venv/neovim3/bin/python'
endif

if filereadable('~/.node_modules/bin/neovim-node-host')
	let g:node_host_prog    = '~/.node_modules/bin/neovim-node-host'
endif

if isdirectory($DATA_PATH)
	set packpath+=$DATA_PATH
endif

" Ensure cache directory
if ! isdirectory(expand($DATA_PATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$DATA_PATH/undo'), 'p')
	call mkdir(expand('$DATA_PATH/backup'))
endif

" Ensure custom spelling directory
if ! isdirectory(expand('$VIMPATH/spell'))
	call mkdir(expand('$VIMPATH/spell'))
endif

" Load vault settings
if filereadable(expand('$VIMPATH/.vault.vim'))
	execute 'source' expand('$VIMPATH/.vault.vim')
endif

function! s:source_lazy(path, ...) abort
	let abspath = resolve(expand($VIMPATH.'/lazy/'.a:path))
	if !stridx(&rtp, abspath) == 0
		execute 'source' fnameescape(abspath)
		return
	endif
endfunction

" Rather than having loads of comments above my mappings I
" try to make well named functions
source ~/.config/nvim/functions.vim

" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_rrhelper = 1  " ?
let g:loaded_shada_plugin = 1  " ?
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

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

" Secure sensitive information, disable backup files in temp directories
if exists('&backupskip')
	set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*
	set backupskip+=.vault.vim
endif

" Disable swap/undo/viminfo/shada files in temp directories or shm
augroup user_secure
	autocmd!
	silent! autocmd BufNewFile,BufReadPre
		\ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim
		\ setlocal noswapfile noundofile nobackup nowritebackup viminfo= shada=
augroup END

set secure
filetype plugin indent on
syntax enable
set mouse=nv                 " Disable mouse in command-line mode
set modeline                 " automatically setting options from modelines
set report=0                 " Don't report on line changes
set errorbells               " Trigger bell on error
set visualbell               " Use visual bell instead of beeping
set hidden                   " hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block
set synmaxcol=1000           " Don't syntax highlight long lines
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap text
set guioptions=M
set lazyredraw               " Don't redraw screen while running macros

" folds
set foldenable
set foldmethod=indent
set foldlevelstart=99
set foldnestmax=5
" specifies for which commands a fold will be opened
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo


" What to save for views and sessions:
set viewoptions=folds,cursor,curdir,slash,unix
set sessionoptions=curdir,help,tabpages,winsize

if has('clipboard')
	set clipboard& clipboard+=unnamedplus
endif
"""""""""""""""""""""""""""""
" Wildmenu
"""""""""""""""""""""""""""""
if has('wildmenu')
	set nowildmenu
	set wildmode=list:longest,full
	set wildoptions=tagfile
	set wildignorecase
	set wildignore+=*.so,.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
	set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
	set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
	set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
	set wildignore+=__pycache__,*.egg-info
endif
"""""""""""""""""""""""""""""
" Vim Directories
"""""""""""""""""""""""""""""
set undofile swapfile nobackup
set undolevels=1000           " How many steps of undo history Vim should remember
set directory=$DATA_PATH/swap//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set undodir=$DATA_PATH/undo//,$DATA_PATH,~/tmp,/var/tmp,/tmp
set backupdir=$DATA_PATH/backup/,$DATA_PATH,~/tmp,/var/tmp,/tmp
set viewdir=$DATA_PATH/view/
set spellfile=$VIM_PATH/spell/en.utf-8.add

" History saving
set history=2000
"  ShaDa/viminfo:
"   ' - Maximum number of previously edited files marks
"   < - Maximum number of lines saved for each register
"   @ - Maximum number of items in the input-line history to be
"   s - Maximum size of an item contents in KiB
"   h - Disable the effect of 'hlsearch' when loading the shada
set shada='300,<50,@100,s10,h
"""""""""""""""""""""""""""""
" Tabs and Indents
"""""""""""""""""""""""""""""
set textwidth=100   " Text width maximum chars before wrapping
set expandtab       " Expand tabs to spaces.
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set cindent         " Increase indent on line after opening brace
set shiftround      " Round indent to multiple of 'shiftwidth'
"""""""""""""""""""""""""""""
" Timing
"""""""""""""""""""""""""""""
set timeout ttimeout
set timeoutlen=500  " Time out on mappings
set ttimeoutlen=10  " Time out on key codes
set updatetime=100  " Idle time to write swap and trigger CursorHold
set redrawtime=1500 " Time in milliseconds for stopping display redraw
"""""""""""""""""""""""""""""
"         Searching         "
"""""""""""""""""""""""""""""
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set hlsearch        " Highlight search results
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
if executable('rg')
	set grepformat=%f:%l:%m
	let &grepprg = 'rg --vimgrep' . (&smartcase ? ' --smart-case' : '')
	let g:rg_derive_root='true'
endif
""""""""""""""""""""""""""""""
"          Behavior          "
""""""""""""""""""""""""""""""
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set shell=/bin/zsh
set switchbuf=useopen,usetab    " Jump to the first open window in any tab
set switchbuf+=vsplit           " Switch buffer behavior to vsplit
set backspace=2
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore whitespace
set showfulltag                 " Show tag and tidy search in completion
set complete+=k                  " No wins, buffs, tags, include scanning
set completeopt=menuone,preview,longest         " Show menu even for one item
set nojoinspaces                " Insert only one space when joining lines that contain sentence-terminating punctuation like `.`.
"""""""""""""""""""""""""""""""""
" Editor UI Appearance
"""""""""""""""""""""""""""""""""
set noshowmode             " Don't show mode in cmd window
set shortmess+=c           " Don't pass messages to |ins-completion-menu|.
set scrolljump=5           " Scroll more than one line
set scrolloff=3            " Keep at least 3 lines above/below
set sidescrolloff=5        " Keep at least 5 lines left/right
set number                 " Show line numbers
set numberwidth=4          " The width of the number column
"set ruler                  " Disable default status ruler
set list                   " Show hidden characters
set listchars=tab:▸\       " Char representing a tab
set listchars+=extends:❯   " Char representing an extending line
set listchars+=nbsp:␣      " Non breaking space
set listchars+=precedes:❮  " Char representing an extending line in the other direction
set listchars+=trail:·     " Show trailing spaces as dots
set nocursorcolumn         " Don't highlight the current column
set cursorline             " Highlight the current line

set signcolumn=yes		" Always show signcolumns
set laststatus=2        " Always show a status line
set showtabline=2       " Always show the tabs line
set winwidth=84         " Minimum width for active window
set winheight=7         " Minimum height for active window
try
	set winminwidth=20      " Minimum width for inactive windows
	set winminheight=7      " Minimum height for inactive windows
catch 
endtry
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

set noshowcmd           " Don't show command in status line
set cmdheight=1         " Height of the command line
set cmdwinheight=5      " Command-line lines
set noequalalways       " Don't resize windows on split or close
set colorcolumn=100     " Highlight the 100th character limit

set guifont=JetBrains\ Mono:h12       " Set GUI font

" Specify the behavior when switching between buffers 
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" Enables 24-bit RGB color in the TUI
if has('termguicolors')
	set termguicolors
	if exists('&pumblend')
		set pumblend=10
	endif
	if exists('&winblend')
		set winblend=10
	endif
endif
"""""""""""""""""""""""""""""
" Auto Commands
"""""""""""""""""""""""""""""
function! s:do_cmd(cmd, bang, start, end, args)
    exec printf('%s%s%s %s', (a:start == a:end ? '' : (a:start.','.a:end)), a:cmd, a:bang, a:args)
endfunction
" Trim whitespace before saving
autocmd BufWritePre * :call TrimWhitespace()
" Reload vim config automatically
autocmd BufWritePost $VIM_PATH/{*.vim,*.json} nested
	\ source $MYVIMRC | redraw
" Autoload packages
augroup Pack
	" alvan/vim-closetag
	autocmd FileType html,xhtml,xml,phtml,jsx packadd vim-closetag
	" arzg/vim-rust-syntax-ext
	autocmd FileType rust packadd rust.vim | packadd vim-rust-syntax-ext
	" euclio/vim-markdown-composer
	autocmd FileType markdown packadd vim-markdown-composer
	" ludovicchabant/vim-gutentags
	autocmd FileType taggers packadd vim-gutentags
	" rust-lang/rust.vim
	autocmd FileType rust packadd rust.vim
	" faith/vim-go
	autocmd FileType go packadd vim-go
	" turbio/bracey.vim
	autocmd FileType html,css,javascript packadd bracey.vim
	" Vim Which Key
	command! -nargs=* -range -bang WhichKey       packadd vim-which-key | call s:source_lazy('which_key.vim') | call which_key#register('<Space>', 'g:which_key_map') 
	command! -nargs=* -range -bang WhichKeyVisual packadd vim-which-key | call s:source_lazy('which_key.vim') | call which_key#register('<Space>', 'g:which_key_map') 
	" Vim Crates
	" Automatically check for new crate versions when opening Cargo.toml
	autocmd BufRead,BufNewFile Cargo.toml packadd vim-crates | call crates#toggle()
	" Vim Vim Abolish 
	autocmd InsertEnter * packadd vim-abolish | call  s:source_lazy('abolish.vim')
	" Rainbow Parentheses
	autocmd InsertEnter * packadd rainbow_parentheses.vim | RainbowParentheses
    autocmd InsertLeave * RainbowParentheses!
	" Git Messenger
	command! -nargs=* -range -bang GitMessenger packadd git-messenger.vim | call s:do_cmd('GitMessenger', "<bang>", <line1>, <line2>, <q-args>)
	" Eunuch Vim
	command! -nargs=* -range -bang Delete    packadd vim-eunuch | call s:do_cmd('Delete'   , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Unlink    packadd vim-eunuch | call s:do_cmd('Unlink'   , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Move      packadd vim-eunuch | call s:do_cmd('Move'     , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Rename    packadd vim-eunuch | call s:do_cmd('Rename'   , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Chmod     packadd vim-eunuch | call s:do_cmd('Chmod'    , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Mkdir     packadd vim-eunuch | call s:do_cmd('Mkdir'    , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Cfind     packadd vim-eunuch | call s:do_cmd('Cfind'    , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Clocate   packadd vim-eunuch | call s:do_cmd('Clocate'  , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Lfind     packadd vim-eunuch | call s:do_cmd('Lfind'    , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Llocate   packadd vim-eunuch | call s:do_cmd('Llocate'  , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang Wall      packadd vim-eunuch | call s:do_cmd('Wall'     , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang SudoWrite packadd vim-eunuch | call s:do_cmd('SudoWrite', "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang SudoEdit  packadd vim-eunuch | call s:do_cmd('SudoEdit' , "<bang>", <line1>, <line2>, <q-args>)
	" Async Run
	command! -nargs=* -range -bang AsyncRun  packadd asyncrun.vim | let g:asyncrun_last = 1 | call s:do_cmd('AsyncRun'  , "<bang>", <line1>, <line2>, <q-args>)
	command! -nargs=* -range -bang AsyncStop packadd asyncrun.vim | let g:asyncrun_last = 1 | call s:do_cmd('AsyncStop' , "<bang>", <line1>, <line2>, <q-args>)
	" Vim StartupTime
	command! -nargs=* -range -bang StartupTime packadd startuptime.vim | call s:do_cmd('StartupTime' , "<bang>", <line1>, <line2>, <q-args>)
	" Vista.vim
	if mapcheck("<leader>tv") == ""
		noremap  <silent> <leader>tv :if !exists('vista#sidebar#Toggle()') <bar> :packadd vista.vim <bar>: call VistaAutoClose() <bar> :endif <bar> :Vista!!<CR>

		" Close vista if it is the only open window
		function! VistaAutoClose()
			autocmd BufEnter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif
		endfunction
	endif
	" Git Messenger
	if mapcheck("<leader>gm") == ""
		nmap  <silent> <leader>gm :if !exists('g:git_messenger_git_command') <bar> :packadd git-messenger.vim <bar>: call VimWhichGM() <bar> :endif <bar><CR> <Plug>(git-messenger)

		function! VimWhichGM()
			let g:git_messenger_no_default_mappings = v:true
		endfunction
	endif
augroup END

augroup MyAutoCmd
	autocmd!
	autocmd Syntax * if line('$') > 5000 | syntax sync minlines=300 | endif
	" Highlight current line only on focused window
	autocmd WinEnter,InsertLeave * set cursorline
	autocmd WinLeave,InsertEnter * set nocursorline
	" Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'
	" Equalize window dimensions when resizing vim window
	autocmd VimResized * tabdo wincmd =
		" Force write shada on leaving nvim
	autocmd VimLeave * wshada! | else | wviminfo!
	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd WinEnter,FocusGained * checktime
	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif
	" Reload Vim script automatically if setlocal autoread
	autocmd BufWritePost,FileWritePost *.vim nested
		\ if &l:autoread > 0 | source <afile> |
		\   echo 'source '.bufname('%') |
		\ endif
	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif
augroup END

augroup miscGroup
	autocmd!
	" somehow this is required to move the gray color of the sign column
	autocmd FileType * highlight clear SignColumn
	" when in a git commit buffer go the beginning
	autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
	" save files when focus is lost
	autocmd BufLeave * silent! update
	" always have quickfix window take up all the horizontal space
	autocmd FileType qf wincmd J
	" Fasto setup
	autocmd BufNewFile,BufRead *.fo setlocal ft=fasto
	" Janus setup
	autocmd BufNewFile,BufRead *.ja setlocal ft=janus
	" C setup, Vim thinks .h is C++
	autocmd BufNewFile,BufRead *.h setlocal ft=c
	" Pow setup
	autocmd BufNewFile,BufRead *.pow setlocal ft=pow
	autocmd BufNewFile,BufRead */playbooks/*.{yml,yaml} setfiletype yaml.ansible
	autocmd BufNewFile,BufRead */inventory/*            setfiletype ansible_hosts
	autocmd BufNewFile,BufRead */templates/*.{yaml,tpl} setfiletype yaml.gotexttmpl
	autocmd BufNewFile,BufRead yarn.lock                setfiletype yaml
	autocmd BufNewFile,BufRead */.kube/config           setfiletype yaml
	autocmd BufNewFile,BufRead *.postman_collection     setfiletype json
	autocmd BufNewFile,BufRead .tern-{project,port}     setfiletype json
	autocmd BufNewFile,BufRead *.lock                   setfiletype json
	autocmd BufNewFile,BufRead *.js.map                 setfiletype json
	autocmd BufNewFile,BufRead .jsbeautifyrc            setfiletype json
	autocmd BufNewFile,BufRead .eslintrc                setfiletype json
	autocmd BufNewFile,BufRead .jscsrc                  setfiletype json
	autocmd BufNewFile,BufRead .babelrc                 setfiletype json
	autocmd BufNewFile,BufRead .watchmanconfig          setfiletype json
	autocmd BufNewFile,BufRead .buckconfig              setfiletype toml
	autocmd BufNewFile,BufRead .flowconfig              setfiletype ini
	autocmd BufNewFile,BufRead *.{feature,story}        setfiletype cucumber
	autocmd BufNewFile,BufRead Jenkinsfile              setfiletype groovy
	autocmd BufNewFile,BufRead Tmuxfile,tmux/config     setfiletype tmux
	autocmd BufNewFile,BufRead Brewfile                 setfiletype ruby
	autocmd BufNewFile,BufRead Justfile,justfile        setfiletype make
	autocmd FileType pow set commentstring={{\ %s\ }}
	autocmd BufWinEnter,WinEnter term://* startinsert
	autocmd BufLeave term://* stopinsert
	autocmd! BufWritePost *.tex call CompileLatex()
	autocmd BufEnter,FocusGained * checktime
	" autocmd FileType rust nnoremap <buffer> <cr> :w<cr>:RustFmt<cr>:w<cr>
	" https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	autocmd FileType css,javascript,javascriptreact setlocal backupcopy=yes

	autocmd FileType mkd       setlocal spell nofoldenable
	autocmd FileType text      setlocal spell nofoldenable
	autocmd FileType gitcommit setlocal spell
	autocmd FileType vim       setlocal foldmethod=marker
	autocmd FileType man nnoremap <silent><buffer> q :<C-u>:quit<CR>

	autocmd! FileType which_key
	autocmd  FileType which_key set laststatus=0 noshowmode noruler
		\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

"""""""""""""""""""""""""""""
" Mapping
"""""""""""""""""""""""""""""
" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" Start an external command with a single bang
nnoremap ! :!

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

" Toggle fold
nnoremap <CR> za

" Focus the current fold by closing all others
nnoremap <S-Return> zMzvzt

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

" Easier line-wise movement
nnoremap gh g^
nnoremap gl g$

" Yank from cursor position to end-of-line
nnoremap Y y$

" Yank buffer's relative/absolute path to clipboard
"nnoremap <Leader>y :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap <leader>y :<C-u>CocList -A --normal yank<cr>
nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" Split Control
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>q :close<CR>
" Window control
nnoremap <C-q> <C-w>
nnoremap <C-x>  :bd<CR>   " delete buffer
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

"switch windw
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

"smart move
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nmap <Tab>   >>_
nmap <S-Tab> <<_

" Make terminal mode behave more like any other mode
tnoremap <C-[> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <A-k> <C-\><C-n><C-W>+i
tnoremap <A-j> <C-\><C-n><C-W>-i
tnoremap <A-h> <C-\><C-n>3<C-W>>i
tnoremap <A-l> <C-\><C-n>3<C-W><i

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(10)<CR>
inoremap <A-t> <Esc>:call TermToggle(10)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(10)<CR>

" Exit insert mode and save just by hitting CTRL-s
noremap <silent><C-s> :<C-u>write \| write<CR>
vnoremap <silent><C-s> :<C-u>write \| write<CR>
cnoremap <silent><C-s> <C-u>write  \| write<CR>

" I like to :quit with 'q', shrug.
nnoremap <silent> q :<C-u>:quit<CR>

" Macros
nnoremap Q q
nnoremap gQ @q
"""""""""""""""""""""""""""""
" Leader Mappings
"""""""""""""""""""""""""""""
""" Vim Buffet """
" Switch Buffers
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

"""" Find """"
nnoremap <silent> <Leader>fa :<C-u>Clap grep2<CR>
nnoremap <silent> <Leader>fb :<C-u>Clap marks<CR>
nnoremap <silent> <leader>fc :<C-u>Clap colors<cr>
nnoremap <silent> <Leader>ff :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
nnoremap <silent> <Leader>fh :<C-u>Clap history<CR>
nnoremap <silent> <leader>fl :<C-u>Clap blines<cr>

" Session management shortcuts (see plugin/sessions.vim)
nmap <leader>sl :<C-u>SessionLoad<CR>
nmap <leader>ss :<C-u>SessionSave<CR>

" Toggle
nnoremap <leader>tf :CocCommand explorer<CR>
nnoremap <leader>tt :call TermToggle(20)<CR>

"" Taken from David Pederson
nnoremap <leader>a  :call YankWholeBuffer(0)<cr>
nnoremap <leader>b  :Clap buffers<cr>
nnoremap <leader>i  :call IndentEntireFile()<cr>
nnoremap <leader>j  :call GotoDefinitionInSplit(0)<cr>
nnoremap <leader>md :set filetype=markdown<cr>
nnoremap <leader>mh :call MakeMarkdownHeading(1)<cr>
nnoremap <leader>mH :call MakeMarkdownHeading(2)<cr>
vnoremap <leader>ml :call PasteMarkdownLink()<cr>
nnoremap <leader>p  :call PasteFromSystemClipBoard()<cr>
nnoremap <leader>w  :wq<cr>
nnoremap <leader>z  :call CorrectSpelling()<cr>
nnoremap <F2>       :call RenameFile()<cr>

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
"""""""""""""""""""""""""""""
" Other 
"""""""""""""""""""""""""""""
let g:coc_data_home	= '~/.config/nvim/coc'
let g:endwise_no_mappings = v:true
inoremap <expr> <Plug>CustomCocCR pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd
nnoremap<C-p> :Clap files<CR>
