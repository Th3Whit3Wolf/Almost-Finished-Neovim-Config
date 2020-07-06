if &compatible
	set nocompatible
endif

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

set noreadonly
"set secure
filetype plugin indent on
syntax enable
set mouse=a                  " Enable mouse
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
set relativenumber
set numberwidth=4          " The width of the number column
set ruler                  " Disable default status ruler
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
	autocmd FileType html,xhtml,xml,phtml,jsx packadd vim-closetag | call LazySource('closetag')
	" ludovicchabant/vim-gutentags
	autocmd FileType Ada,AnsiblePlaybook,Ant,Asciidoc,Asm,Asp,Autoconf,AutoIt,Automake,Awk,Basic,BETA,BibTeX,C,C#,C++,Clojure,CMake,Cobol,CPreProcessor,CSS,Ctags,CUDA,D,DBusIntrospect,Diff,DosBatch,DTD,DTS,Eiffel,Elixir,Elm,Erlang,Falcon,Flex,Fortran,Fypp,Gdbinit,Glade,Go,HTML,Iniconf,Inko,ITcl,Java,JavaProperties,JavaScript,JSON,LdScript,Lisp,Lua,M4,Make,Man,Markdown,MatLab,Maven2,Moose,Myrddin,NSIS,ObjectiveC,OCaml,OldC,[disabled],OldC++,[disabled],Pascal,Passwd,Perl,Perl6,PHP,PlistXML,Pod,PowerShell,Protobuf,PuppetManifest,Python,PythonLoggingConfig,QemuHX,QtMoc,R,RelaxNG,ReStructuredText,REXX,Robot,RpmSpec,RSpec,Ruby,Rust,Scheme,SCSS,Sh,SLang,SML,SQL,SVG,SystemdUnit,SystemTap,SystemVerilog,Tcl,TclOO,Tex,TTCN,TypeScript,Varlink,Vera,Verilog,VHDL,Vim,WindRes,XML,XSLT,YACC,Yaml,YumRepo,Zephir packadd vim-gutentags | call LazySource('gutentags')
	" Vim Crates
	" Automatically check for new crate versions when opening Cargo.toml
	autocmd BufRead,BufNewFile Cargo.toml packadd vim-crates | call crates#toggle()
	" Vim Vim Abolish
	autocmd InsertEnter * packadd vim-abolish | call  LazySource('abolish')
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
	packadd vim-which-key | call LazySource('which_key') | call which_key#register('<Space>', 'g:which_key_map')
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
	" save files when focus is lost
	autocmd BufLeave * silent! update
	autocmd FileType pow set commentstring={{\ %s\ }}
	autocmd BufWinEnter,WinEnter term://* startinsert
	autocmd BufLeave term://* stopinsert
	" autocmd! BufWritePost *.tex call CompileLatex()
	autocmd BufEnter,FocusGained * checktime
	autocmd FileType text      setlocal spell nofoldenable
	autocmd FileType vim       setlocal foldmethod=marker
	autocmd FileType man nnoremap <silent><buffer> q :<C-u>:quit<CR>

	autocmd! FileType which_key
	autocmd  FileType which_key set laststatus=0 noshowmode noruler
		\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

	autocmd TermEnter * call LazySource('terminal')
	autocmd FilterWritePost * if (&diff) | call LazySource('diff') | DiffOrig | endif
augroup END
"""""""""""""""""""""""""""""
" Mapping
"""""""""""""""""""""""""""""
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
nnoremap <CR> :packadd FastFold <bar> LazySource('fastfold') <bar> packadd FoldText <bar><CR> za

" Focus the current fold by closing all others
nnoremap <S-Return> :packadd FastFold <bar> LazySource('fastfold') <bar> packadd FoldText <bar><CR> zMzvzt

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

" Easier line-wise movement
nnoremap gh g^
nnoremap gl g$

" Yank from cursor position to end-of-line
nnoremap Y y$

" Window control
nnoremap <C-q> <C-w>
nnoremap <C-x>  :bd!<CR>   " delete buffer
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

"switch windw
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

if exists('g:eliteMode')
	" Disable arrow movement, resize splits instead.
	nnoremap <silent><Up>    :resize +1<CR>
	nnoremap <silent><Down>  :resize -1<CR>
	nnoremap <silent><Left>  :vertical resize +1<CR>
	nnoremap <silent><Right> :vertical resize -1<CR>

	" Insert navigation
	noremap! <Leader>h <left>
	noremap! <Leader>j <down>
	noremap! <Leader>k <up>
	noremap! <Leader>l <right>
	noremap! <Leader>w <esc>wi
	noremap! <Leader>e <esc>ei
	noremap! <Leader>b <esc>bi
endif
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

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(10)<CR>
inoremap <A-t> <Esc>:call TermToggle(10)<CR>

" Exit insert mode and save just by hitting CTRL-s
noremap <silent><C-s> :<C-u>write \| write<CR>
vnoremap <silent><C-s> :<C-u>write \| write<CR>
cnoremap <silent><C-s> <C-u>write  \| write<CR>

" I like to :quit with 'q', shrug.
nnoremap <silent> q :<C-u>:quit<CR>

" Yank buffer's relative/absolute path to clipboard
"nnoremap <Leader>y :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap <leader>y :<C-u>CocList -A --normal yank<cr>
nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>

" Split Control
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <leader>sq :close<CR>

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
nnoremap <Leader>ts :setlocal spell!<cr>
nnoremap <Leader>tn :setlocal nonumber!<CR>
nnoremap <Leader>tl :setlocal nolist!<CR>
" Smart wrap toggle (breakindent and colorcolumn toggle as-well)
nmap <Leader>tw :execute('setlocal wrap! breakindent! colorcolumn=' .
	\ (&colorcolumn == '' ? &textwidth : ''))<CR>

nnoremap  <leader>cs :call Changebang()<CR>
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

"" Taken from David Pederson
nnoremap <leader>a  :call YankWholeBuffer(0)<cr>
nnoremap <leader>i  :call IndentEntireFile()<cr>
nnoremap <leader>j  :call GotoDefinitionInSplit(0)<cr>
nnoremap <leader>md :set filetype=markdown<cr>
nnoremap <leader>mh :call MakeMarkdownHeading(1)<cr>
nnoremap <leader>mH :call MakeMarkdownHeading(2)<cr>
vnoremap <leader>ml :call PasteMarkdownLink()<cr>
nnoremap <leader>p  :call PasteFromSystemClipBoard()<cr>
nnoremap <leader>z  :call CorrectSpelling()<cr>
nnoremap <F2>       :call RenameFile()<cr>
"""""""""""""""""""""""""""""
" Other
"""""""""""""""""""""""""""""
let g:coc_data_home	= '~/.config/nvim/coc'
let g:endwise_no_mappings = v:true
inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd
nnoremap<C-p> :Clap files<CR>

augroup bang
	autocmd!
	autocmd BufNewFile *.awk     0put =\"#!/usr/bin/env awk"
	autocmd BufNewFile *.escript 0put =\"#!/usr/bin/env escript"
	autocmd BufNewFile *.fish    0put =\"#!/usr/bin/env fish"
	autocmd BufNewFile *.ion     0put =\"#!/usr/bin/env ion"
	autocmd BufNewFile *jl       0put =\"#!/usr/bin/env julia"
	autocmd BufNewFile *.lua     0put =\"#!/usr/bin/env lua"
	autocmd BufNewFile *.php     0put =\"#!/usr/bin/env php"
	autocmd BufNewFile *.pl      0put =\"#!/usr/bin/env perl"
	autocmd BufNewFile *.rb      0put =\"#!/usr/bin/env ruby"
	autocmd BufNewFile *.scala   0put =\"#!/usr/bin/env scala"
augroup END
