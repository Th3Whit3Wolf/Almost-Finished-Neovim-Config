local global = require 'global'
local vim = vim
local options = {}

-- Set Options
-- -------------------- | ----
-- Global Options       | vim.o
-- Buffer Local Options | vim.bo
-- Window Local Options | vim.wo

function options:new()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function options:load_options()
    self.mouse = "a"; -- Enable mouse
    self.report = 0; -- Automatically setting options from modelines
    self.errorbells = true; -- Trigger bell on error
    self.visualbell = true; -- Use visual bell instead of beeping
    self.hidden = true; -- hide buffers when abandoned instead of unload
    self.fileformats = "unix,mac,dos"; -- Use Unix as the standard file type
    self.magic = true; -- For regular expressions turn magic on
    self.path = ".,**"; -- Directories to search when using gf
    self.virtualedit = "block"; -- Position cursor anywhere in visual block
    self.synmaxcol = 2500; -- Don't syntax highlight long lines
    self.formatoptions = "1jcroql"; -- Don't break lines after a one-letter word & Don't auto-wrap text
    self.lazyredraw = true; -- Don't redraw screen while running macros
    self.encoding = "utf-8";

    -- What to save for views and sessions:
    self.viewoptions = "folds,cursor,curdir,slash,unix";
    self.sessionoptions = "curdir,help,tabpages,winsize";

    self.clipboard = "unnamedplus";

    -- Wildmenu
    self.wildmenu = false;
    self.wildmode = 'list:longest,full';
    self.wildoptions = 'tagfile';
    self.wildignorecase = true;

    self.wildignore =
        "*.so,.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**,*/.sass-cache/*,application/vendor/**,**/vendor/ckeditor/**,media/vendor/**,__pycache__,*.egg-info";

    -- Neovim Directories
    self.backup = false;
    self.writebackup = false;
    self.undofile = true;
    self.swapfile = true;
    self.undolevels = 1000; -- How many steps of undo history Vim should remember
    self.directory = global.cache_dir .. "swap/," .. global.cache_dir .. ",~/tmp,/var/tmp,/tmp";
    self.undodir = global.cache_dir .. "undo/," .. global.cache_dir .. ",~/tmp,/var/tmp,/tmp";
    self.backupdir = global.cache_dir .. "backup/," .. global.cache_dir .. ",~/tmp,/var/tmp,/tmp";
    self.backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim";
    self.viewdir = global.cache_dir .. "view/," .. global.cache_dir .. ",~/tmp,/var/tmp,/tmp";
    self.spellfile = global.cache_dir .. "spell/en.uft-8.add";
    self.history = 2000; -- History saving
    --  ShaDa/viminfo:
    --   ' - Maximum number of previously edited files marks
    --   < - Maximum number of lines saved for each register
    --   @ - Maximum number of items in the input-line history to be
    --   s - Maximum size of an item contents in KiB
    --   h - Disable the effect of 'hlsearch' when loading the shada
    self.shada = "!,'300,<50,@100,s10,h";

    -- Tabs and Indents
    self.textwidth = 100; -- Text width maximum chars before wrapping
    self.expandtab = true; -- Expand tabs to spaces.
    self.tabstop = 2; -- The number of spaces a tab is
    self.shiftwidth = 2; -- Number of spaces to use in auto(indent)
    self.softtabstop = -1; -- Number of spaces to use in auto(indent)
    self.smarttab = true; -- Tab insert blanks according to 'shiftwidth'
    self.autoindent = true; -- Use same indenting on new lines
    self.shiftround = true; -- Round indent to multiple of 'shiftwidth'
    self.cindent = true; -- Increase indent on line after opening brace
    self.breakindentopt = "shift:2,min:20"; -- Settingf for breakindent

    -- Timing
    self.timeout = true;
    self.ttimeout = true;
    self.timeoutlen = 500; -- Time out on mappings
    self.ttimeoutlen = 10; -- Time out on key codes
    self.updatetime = 100; -- Idle time to write swap and trigger CursorHold
    self.redrawtime = 1500; -- Time in milliseconds for stopping display redraw

    -- Searching
    self.ignorecase = true; -- Search ignoring case
    self.smartcase = true; -- Keep case when searching with *
    self.infercase = true; -- Adjust case in insert completion mode
    self.incsearch = true; -- Incremental search
    self.hlsearch = true; -- Highlight search results
    self.wrapscan = true; -- Searches wrap around the end of the file
    self.showmatch = true; -- Jump to matching bracket
    self.matchpairs = '(:),{:},[:],<:>'; -- Add HTML brackets to pair matching
    self.matchtime = 1; -- Tenths of a second to show the matching paren
    self.grepformat = "%f:%l:%c:%m";
    self.grepprg = 'rg --hidden --vimgrep --smart-case --';

    -- Behavior
    self.wrap = false; -- No wrap by default
    self.linebreak = true; -- Break long lines at 'breakat'
    self.breakat = [[\ \	;:,!?]]; -- Long lines break chars
    self.startofline = false; -- Cursor in same column for few commands
    self.whichwrap = "h,l,<,>,[,],~"; -- Move to following line on certain keys
    self.shell = '/bin/zsh'; -- Use zsh shell in terminal
    self.splitbelow = true; -- Splits open bottom
    self.splitright = true; -- Splits open right
    self.switchbuf = "useopen,usetab,vsplit"; -- Jump to the first open window in any tab & switch buffer behavior to vsplit
    self.backspace = "indent,eol,start"; -- Intuitive backspacing in insert mode
    self.diffopt = "filler,iwhite,internal,algorithm:patience"; -- Diff mode: show fillers, ignore whitespace, use internal patience diff library,
    self.showfulltag = true; -- Show tag and tidy search in completion
    self.complete = ".,w,b,k"; -- No wins, buffs, tags, include scanning
    self.inccommand = "nosplit";
    self.completeopt = "menu,menuone,noselect,noinsert,preview"; -- Set completeopt to have a better completion experience
    self.joinspaces = false; -- Insert only one space when joining lines that contain sentence-terminating punctuation like `.`.
    self.jumpoptions = "stack"; -- list of words that change the behavior of the jumplist

    -- Editor UI Appearance
    self.showmode = false; -- Don't show mode in cmd window
    self.shortmess = "filnxtToOFc"; -- Don't pass messages to |ins-completion-menu|.
    self.scrolloff = 3; -- Keep at least 3 lines above/below
    self.sidescrolloff = 5; -- Keep at least 5 lines left/right
    self.relativenumber = true; -- Show line number relative to current line
    self.numberwidth = 4; -- The width of the number column
    self.ruler = false; -- Disable default status ruler
    self.list = true; -- Show hidden characters
    self.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←";
    self.cursorcolumn = false; -- Don't highlight the current column
    self.cursorline = true; -- Highlight the current line

    self.signcolumn = "yes"; -- Always show signcolumns
    self.laststatus = 2; -- Always show a status line
    self.showtabline = 2; -- Always show the tabs line
    self.winwidth = 30;
    self.winminwidth = 10;
    self.pumheight = 15; -- Pop-up menu's line height
    self.helpheight = 12; -- Minimum help window height
    self.previewheight = 12; -- Completion preview height

    self.showcmd = false; -- Don't show command in status line
    self.cmdheight = 2; -- Height of the command line
    self.cmdwinheight = 5; -- Command-line lines
    self.equalalways = false; -- Don't resize windows on split or close
    self.colorcolumn = "100"; -- Highlight the 100th character limit
    self.display = "lastline";
    self.termguicolors = true;
    self.pumblend = 10;
    self.showbreak = "↳  ";
    self.conceallevel = 2;
    self.concealcursor = "niv";

    -- fold
    self.foldenable = true;
    self.foldmethod = "indent";
    self.foldexpr = "nvim_treesitter#foldexpr()"; -- Treesitter Syntax based code folding
    self.foldlevelstart = 99;

    for name, value in pairs(self) do
        vim.o[name] = value
        -- Show line numbers, surprisingly not a global options
        vim.wo.number = true
    end
end

return options

