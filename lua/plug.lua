local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init()
    end

    local use = packer.use
    packer.reset()

    -- Packer
    use {
        'wbthomason/packer.nvim',
        opt = true
    }

    -- Vim plugin, insert or delete brackets, parens, quotes in pair 
    use {'jiangmiao/auto-pairs'}

    -- plugin for interacting with databases
    use {'tpope/vim-dadbod'}

    -- Like pgadmin but for vim
    use {'kristijanhusak/vim-dadbod-ui'}

    -- Most beautiful & fastest statusline
    use {'glepnir/spaceline.vim'}

    -- Devicons (requirement for spaceline)
    use {'ryanoasis/vim-devicons'}

    -- Modern vim-startify
    use {'hardcoreplayers/dashboard-nvim'}

    --  Modern performant generic finder and dispatcher for NeoVim 
    use {
        'liuchengxu/vim-clap',
        run = ':Clap install-binary!'
    }

    ---------
    -- Lua --
    ---------

    -- Collection of common configurations for the Nvim LSP client.
    use {
        'neovim/nvim-lspconfig',
        event = 'InsertEnter *'
    }

    -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
    use {
        'tjdevries/lsp_extensions.nvim',
        event = 'InsertEnter *'
    }

    -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
    use {'nvim-lua/completion-nvim'}

    -- wraps the diagnostics setting to make it more user friendly
    use {
        'nvim-lua/diagnostic-nvim',
        event = 'InsertEnter *'
    }

    -- Treesitter configurations and abstraction layer for Neovim. 
    use {
        'nvim-treesitter/nvim-treesitter',
        ft = {'sh', 'c', 'cs', 'cpp', 'css', 'dart', 'elm', 'fennel', 'go', 'haskell', 'html', 'java', 'javascript',
              'jsdoc', 'julia', 'lua', 'markdown', 'nix', 'ocaml', 'php', 'python', 'ql', 'rst', 'ruby', 'rust',
              'scala', 'swift', 'toml', 'tsx', 'typescript', 'vue', 'yaml'},
        config = function()
            vim.cmd [[ setlocal foldmethod=expr ]]
            vim.cmd [[ setlocal foldexpr=nvim_treesitter#foldexpr() ]]
        end
    }

    -- Treesitter based completion sources.
    use {
        'nvim-treesitter/completion-treesitter',
        ft = {'sh', 'c', 'cs', 'cpp', 'css', 'dart', 'elm', 'fennel', 'go', 'haskell', 'html', 'java', 'javascript',
              'jsdoc', 'julia', 'lua', 'markdown', 'nix', 'ocaml', 'php', 'python', 'ql', 'rst', 'ruby', 'rust',
              'scala', 'swift', 'toml', 'tsx', 'typescript', 'vue', 'yaml'},
        run = 'TSInstall all'
    }

    -- Completion for buffers word.
    use {'steelsojka/completion-buffers'}

    -- Completion sources for vim-dadbod
    use {'tpope/vim-dadbod"'}
    use {'kristijanhusak/vim-dadbod-ui'}
    use {'kristijanhusak/vim-dadbod-completion'}

    -- Slightly improved ctags completion
    use {
        'kristijanhusak/completion-tags',
        ft = {'ada', 'ansible', 'asm', 'awk', 'bib', 'c', 'clojure', 'cobol', 'cmake', 'cpp', 'cs', 'css', 'd',
              'elixir', 'elm', 'erlang', 'fortan', 'go', 'html', 'java', 'json', 'lisp', 'lua', 'm4', 'make',
              'markdown', 'matlab', 'objc', 'ocaml', 'pascal', 'perl', 'perl6', 'php', 'ps1', 'ps1xml', 'proto',
              'python', 'r', 'rst', 'ruby', 'rust', 'scss', 'sh', 'sql', 'svg', 'systemd', 'tex', 'typescript',
              'verilog', 'vhdl', 'vim', 'xml', 'xsl', 'yaml', 'zephir'}
    }

    -- devicons in lua
    use {'kyazdani42/nvim-web-devicons'}

    -- A File Explorer For Neovim Written In Lua
    use {'kyazdani42/nvim-tree.lua'}

    -- Snippets tool written in lua
    use {'norcalli/snippets.nvim'}

    -- A format runner for neovim, written in lua
    use {'mhartington/formatter.nvim'}

    -- My spacemacs colorscheme
    use {'Th3Whit3Wolf/space-nvim-theme'}

    ----------
    -- Lazy --
    ----------

    -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
    use {
        'mhinz/vim-signify',
        opt = true
    }

    -- Vim sugar for the UNIX shell commands
    use {
        'tpope/vim-eunuch',
        cmd = {'Delete', 'Unlink', 'Move', 'Rename', 'Chmod', 'Mkdir', 'Cfind', 'Clocate', 'Lfind', 'Llocate', 'Wall',
               'SudoWrite', 'SudoEdit'}
    }

    -- shows the history of commits under the cursor in popup window
    use {
        'rhysd/git-messenger.vim',
        opt = true
    }

    -- Vim plugin that shows keybindings in popup 
    use {
        'liuchengxu/vim-which-key',
        opt = true
    }

    -- improves the git commit buffer
    use {
        'rhysd/committia.vim',
        opt = true
    }

    -- easily search for, substitute, and abbreviate multiple variants of a word 
    use {
        'tpope/vim-abolish',
        event = 'InsertEnter *'
    }

    -- Asynchronously control git repositories in Neovim
    use {
        'lambdalisue/gina.vim',
        opt = true
    }

    -- Vim script for text filtering and alignment 
    use {
        'godlygeek/tabular',
        opt = true
    }

    -- Viewer & Finder for LSP symbols and tags
    use {
        'liuchengxu/vista.vim',
        cmd = 'Vista'
    }

    -- Auto close (X)HTML tags 
    use {
        'alvan/vim-closetag',
        ft = {'html', 'javascript', 'xhtml', 'phtml', 'xml'}
    }

    -- live edit html, css, and javascript in vim 
    use {
        'turbio/bracey.vim',
        run = 'yarn --prefix server',
        ft = {'html', 'css', 'javascript'}
    }

    -- An asynchronous markdown preview plugin for Neovim
    use {
        'euclio/vim-markdown-composer',
        run = 'cargo build --release',
        ft = {'markdown'},
        cmd = {'ComposerOpen', 'ComposerUpdate'}
    }

    -- Minimap for vim
    use {
        'wfxr/minimap.vim',
        run = 'cargo install --locked code-minimap'
    }

    -- Simpler Rainbow Parentheses 
    use {
        'alok/rainbow_parentheses.vim',
        event = 'InsertEnter *',
        run = 'git checkout fix-spell'
    }

    -- Read DotEnv
    use {
        'tpope/vim-dotenv',
        cmd = 'Dotenv'
    }
    
    -- Profiling
    use {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime'
    }

    -----------
    -- Prose --
    -----------

    -- Add all of these in  `lazy/git`
    -- Uncover usage problems in your writing
    use {
        'reedes/vim-wordy',
        cmd = {'PrevWordy', 'Wordy', 'NextWordy'}
    }

    -- Highlights overused words
    use {
        'dbmrq/vim-ditto',
        cmd = {'DittoNext', 'DittoPrev', 'DittoGood', 'DittoBad', 'DittoMore', 'DittoLess', 'DittoOn'}
    }

    -- Building on Vim’s spell-check and thesaurus/dictionary completion
    use {
        'reedes/vim-lexical',
        ft = {'asciidoc', 'rst', 'mail', 'html', 'text', 'textile', 'markdown', 'tex', 'xml'}
    }
    -- handful of tweaks needed to smooth the path to writing prose
    use {
        'reedes/vim-pencil',
        ft = {'asciidoc', 'rst', 'mail', 'html', 'text', 'textile', 'markdown', 'tex', 'xml'}
    }

    ---------------
    -- FTPlugins --
    ---------------

    -- ACPI ASL
    use {
        'martinlroth/vim-acpi-asl',
        ft = {'asl'}
    }

    -- Ansible 2.x
    use {
        'pearofducks/ansible-vim',
        ft = {'ansible'}
    }

    -- API Blueprint
    use {
        'sheerun/apiblueprint.vim',
        ft = {'apiblueprint'}
    }

    -- AppleScript
    use {
        'mityu/vim-applescript',
        ft = {'applescript'}
    }

    -- Arduino
    use {
        'sudar/vim-arduino-syntax',
        ft = {'arduino'}
    }

    -- AsciiDoc
    use {
        'asciidoc/vim-asciidoc',
        ft = {'asciidoc'}
    }

    -- BATS
    use {
        'aliou/bats.vim',
        ft = {'bats'}
    }

    -- Bazel
    use {
        'bazelbuild/vim-bazel',
        ft = {'bzl'}
    }

    -- Bazel
    use {
        'google/vim-maktaba',
        ft = {'bzl'}
    }

    -- Blade templates
    use {
        'jwalton512/vim-blade',
        ft = {'blade'}
    }

    -- Brewfile
    use {
        'bfontaine/Brewfile.vim',
        ft = {'brewfile'}
    }

    -- C#
    use {
        'OrangeT/vim-csharp',
        ft = {'cs', 'xml', 'cshtml.html', 'aspx.html'}
    }

    -- C#
    use {
        'OmniSharp/omnisharp-vim',
        ft = {'cs', 'omnisharplog'}
    }

    -- Caddyfile
    use {
        'isobit/vim-caddyfile',
        ft = {'caddyfile'}
    }

    -- Cargo Make (Rust cargo extension)
    use {
        'nastevens/vim-cargo-make',
        ft = {'cargo-make'}
    }

    -- Cargo.toml (Rust)
    use {
        'mhinz/vim-crates',
        opt = true
    }

    -- Carp
    use {
        'hellerve/carp-vim',
        ft = {'carp'}
    }

    -- Chef
    use {
        'vadv/vim-chef',
        ft = {'chef'}
    }

    -- Clojure
    use {
        'guns/vim-clojure-static',
        ft = {'clojure'}
    }

    -- Clojure
    use {
        'tpope/vim-fireplace',
        ft = {'clojure'}
    }

    -- Clojure
    use {
        'guns/vim-clojure-highlight',
        ft = {'clojure'}
    }

    -- Clojure
    use {
        'Olical/conjure',
        ft = {'clojure', 'fennel'}
    }

    -- LISP languages
    use {
        'eraserhd/parinfer-rust',
        ft = {'clojure', 'lisp', 'scheme', 'racket', 'jbuild', 'fennel', 'pddl'},
        run = 'cargo build --release'
    }

    -- Cmake
    use {
        'pboettch/vim-cmake-syntax',
        ft = {'cmake'}
    }

    -- Cmake
    use {
        'vhdirk/vim-cmake',
        ft = {'cmake'}
    }

    -- CoffeScript
    use {
        'kchmck/vim-coffee-script',
        ft = {'coffee'}
    }

    -- CJSX (JSX equivalent in CoffeeScript)
    use {
        'mtscout6/vim-cjsx',
        ft = {'coffee'}
    }

    -- Cassandra CQL
    use {
        'elubow/cql-vim',
        ft = {'cql'}
    }

    -- Cryptol
    use {
        'victoredwardocallaghan/cryptol.vim',
        ft = {'cryptol'}
    }

    -- Crystal
    use {
        'vim-crystal/vim-crystal',
        ft = {'crystal'}
    }

    -- CSS
    use {
        'hail2u/vim-css3-syntax',
        ft = {'css'},
        config = function()
            vim.cmd [[ set backupcopy=yes ]]
            vim.cmd [[ setlocal iskeyword+=- ]]
        end
    }

    -- CSV
    use {
        'chrisbra/csv.vim',
        ft = {'csv'}
    }

    -- Cucumber
    use {
        'tpope/vim-cucumber',
        ft = {'cucumber'}
    }

    -- Cue
    use {
        'mgrabovsky/vim-cuesheet',
        ft = {'cue'}
    }

    -- Cypher
    use {
        'jjaderberg/vim-syntax-cipher',
        ft = {'cypher'}
    }

    -- D Lang
    use {
        'JesseKPhillips/d.vim',
        ft = {'d', 'dcov', 'dd', 'ddoc', 'dsdl'}
    }

    -- Dafny
    use {
        'mlr-msft/vim-loves-dafny',
        ft = {'dafny'}
    }

    -- Dart
    use {
        'dart-lang/dart-vim-plugin',
        ft = {'dart'}
    }

    -- Dhall
    use {
        'vmchale/dhall-vim',
        ft = {'dhall'}
    }

    -- Dockerfile
    use {
        'ekalinin/Dockerfile.vim',
        ft = {'docker-compose', 'dockerfile'}
    }

    -- Duckscript
    use {
        'ekalinin/Dockerfile.vim',
        ft = {'cargo-make', 'duckscript'}
    }

    -- Elixir
    use {
        'elixir-editors/vim-elixir',
        ft = {'elixir'}
    }

    -- Emblem
    use {
        'yalesov/vim-emblem',
        ft = {'emblem'}
    }

    -- Erlang
    use {
        'vim-erlang/vim-erlang-runtime',
        ft = {'erlang'}
    }

    -- Fennel
    use {
        'bakpakin/fennel.vim',
        ft = {'fennel'}
    }

    -- Ferm
    use {
        'vim-scripts/ferm.vim',
        ft = {'ferm'}
    }

    -- Fish
    use {
        'georgewitteman/vim-fish',
        ft = {'fish'}
    }

    -- Flatbuffers
    use {
        'dcharbon/vim-flatbuffers',
        ft = {'fbs'}
    }

    -- Fountain
    use {
        'kblin/vim-fountain',
        ft = {'fountain'}
    }

    -- GDScript 3
    use {
        'calviken/vim-gdscript3',
        ft = {'gdscript3', 'gsl'}
    }

    -- Git
    use {
        'tpope/vim-git',
        ft = {'git', 'gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail'}
    }

    -- OpenGL Shading Language
    use {
        'tikhomirov/vim-glsl',
        ft = {'glsl'}
    }

    -- Gleam
    use {
        'gleam-lang/gleam.vim',
        ft = {'gleam'}
    }

    -- GMPL
    use {
        'maelvls/gmpl.vim',
        ft = {'gmpl'}
    }

    -- GNUPlot
    use {
        'vim-scripts/gnuplot-syntax-highlighting',
        ft = {'gnuplot'}
    }

    -- Go
    use {
        'fatih/vim-go',
        ft = {'go'},
        run = ':GoUpdateBinaries'
    }

    -- Gradle
    use {
        'tfnico/vim-gradle',
        ft = {'groovy'}
    }

    -- GraphQL
    use {
        'jparise/vim-graphql',
        ft = {'graphql', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue'}
    }

    -- Hack
    use {
        'hhvm/vim-hack',
        ft = {'hack'}
    }

    -- Haml
    use {
        'sheerun/vim-haml',
        ft = {'haml', 'sass'}
    }

    -- Handlebars
    use {
        'mustache/vim-mustache-handlebars',
        ft = {'handlebars', 'mustache'}
    }

    -- HAProxy
    use {
        'CH-DanReif/haproxy.vim',
        ft = {'haproxy'}
    }

    -- Haskel
    use {
        'neovimhaskell/haskell-vim',
        ft = {'haskell'}
    }

    -- Haxe
    use {
        'yaymukund/vim-haxe',
        ft = {'haxe'}
    }

    -- HCL
    use {
        'b4b4r07/vim-hcl',
        ft = {'hcl'}
    }

    -- Helm Templates
    use {
        'towolf/vim-helm',
        ft = {'helm'}
    }

    -- Hive
    use {
        'zebradil/hive.vim',
        ft = {'hive'}
    }

    -- HTML5
    use {
        'othree/html5.vim',
        ft = {'html'}
    }

    -- i3
    use {
        'mboughaba/i3config.vim',
        ft = {'i3config'}
    }

    -- icalendar
    use {
        'chutzpah/icalendar.vim',
        ft = {'icalendar'}
    }

    -- Idris
    use {
        'idris-hackers/idris-vim',
        ft = {'idris'}
    }

    -- Info
    use {
        'HiPhish/info.vim',
        ft = {'info'}
    }

    -- Ion
    use {
        'vmchale/ion-vim',
        ft = {'ion'}
    }

    -- ISPC
    use {
        'jez/vim-ispc',
        ft = {'ispc'}
    }

    -- JST
    use {
        'briancollins/vim-jst',
        ft = {'jst'}
    }

    -- JSX
    use {
        'maxmellon/vim-jsx-pretty',
        ft = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}
    }

    -- Jenkins
    use {
        'martinda/Jenkinsfile-vim-syntax',
        ft = {'jenkins'}
    }

    -- Jinja
    use {
        'lepture/vim-jinja',
        ft = {'jinja'}
    }

    -- Json
    use {
        'elzr/vim-json',
        ft = {'json'}
    }

    -- Json5
    use {
        'GutenYe/json5.vim',
        ft = {'json5'}
    }

    -- Julia
    use {
        'JuliaEditorSupport/julia-vim',
        ft = {'julia'}
    }

    -- Kotlin
    use {
        'udalov/kotlin-vim',
        ft = {'kotlin'}
    }

    -- Latex
    use {
        'lervag/vimtex',
        ft = {'tex', 'bib'}
    }

    -- Latex
    use {
        'xuhdev/vim-latex-live-preview',
        ft = {'tex'}
    }

    -- Ledger
    use {
        'ledger/vim-ledger',
        ft = {'ledger'}
    }

    -- Less
    use {
        'groenewege/vim-less',
        ft = {'less'}
    }

    -- Lilypond
    use {
        'sersorrel/vim-lilypond',
        ft = {'lilypond'}
    }

    -- LiveScript
    use {
        'gkz/vim-ls',
        ft = {'ls'}
    }

    -- Log
    use {
        'MTDL9/vim-log-highlighting',
        ft = {'log'}
    }

    -- Macports
    use {
        'jstrater/mpvim',
        ft = {'portfile'}
    }

    -- Mako
    use {
        'sophacles/vim-bundle-mako',
        ft = {'mako'}
    }

    -- Markdown
    use {
        'plasticboy/vim-markdown',
        ft = {'markdown'}
    }

    -- Markdown (Github)
    use {
        'rhysd/vim-gfm-syntax',
        opt = true
    }

    -- Mathematica
    use {
        'voldikss/vim-mma',
        ft = {'mma'}
    }

    -- Matlab
    use {
        'daeyun/vim-matlab',
        ft = {'matlab'}
    }

    -- MDX
    use {
        'jxnblk/vim-mdx-js',
        ft = {'mdx'}
    }

    -- Mercury
    use {
        'stewy33/mercury-vim',
        ft = {'mercury'}
    }

    -- MoonScript
    use {
        'leafo/moonscript-vim',
        ft = {'moon'}
    }

    -- Nginx
    use {
        'chr4/nginx.vim',
        ft = {'nginx'}
    }

    -- Nim
    use {
        'zah/nim.vim',
        ft = {'nim'}
    }

    -- Nix
    use {
        'LnL7/vim-nix',
        ft = {'nix'}
    }

    -- Objective-C
    use {
        'b4winckler/vim-objc',
        ft = {'objc'}
    }

    -- OCaml
    use {
        'ocaml/vim-ocaml',
        ft = {'dune', 'oasis', 'ocaml', 'ocamlbuild_tags', 'omake', 'sexplib'}
    }

    -- Octave
    use {
        'McSinyx/vim-octave',
        ft = {'octave'}
    }

    -- Pawn
    use {
        'mcnelson/vim-pawn',
        ft = {'pawn'}
    }

    -- Pandoc
    use {
        'vim-pandoc/vim-pandoc',
        ft = {'pandoc'}
    }

    -- Pandoc
    use {
        'vim-pandoc/vim-pandoc-syntax',
        ft = {'pandoc'}
    }

    -- PERL
    use {
        'vim-perl/vim-perl',
        ft = {'perl', 'perl6'}
    }

    -- PostgreSQL
    use {
        'lifepillar/pgsql.vim',
        ft = {'pgsql'}
    }

    -- PHP
    use {
        'StanAngeloff/php.vim',
        ft = {'php'}
    }

    -- PlantUML
    use {
        'aklt/plantuml-syntax',
        ft = {'plantuml'}
    }

    -- Ponylang
    use {
        'jakwings/vim-pony',
        ft = {'pony'}
    }

    -- PowerShell
    use {
        'PProvost/vim-ps1',
        ft = {'ps1', 'ps1xml'}
    }

    -- Prolog
    use {
        'adimit/prolog.vim',
        ft = {'prolog'}
    }

    -- Protocol Buffers
    use {
        'uarun/vim-protobuf',
        ft = {'proto'}
    }

    -- Pug
    use {
        'digitaltoad/vim-pug',
        ft = {'pug'}
    }

    -- Puppet
    use {
        'rodjek/vim-puppet',
        ft = {'puppet', 'embeddedpuppet'}
    }

    -- PureScript
    use {
        'purescript-contrib/purescript-vim',
        ft = {'purescript'}
    }

    -- QMake
    use {
        'artoj/qmake-syntax-vim',
        ft = {'qmake'}
    }

    -- QML
    use {
        'peterhoeg/vim-qml',
        ft = {'qml'}
    }

    -- R
    use {
        'jalvesaq/Nvim-R',
        ft = {'r'}
    }

    -- Racket
    use {
        'wlangstroth/vim-racket',
        ft = {'racket'}
    }

    -- Ragel
    use {
        'jneen/ragel.vim',
        ft = {'ragel'}
    }

    -- Raku
    use {
        'Raku/vim-raku',
        ft = {'raku'}
    }

    -- RAML
    use {
        'IN3D/vim-raml',
        ft = {'raml'}
    }

    -- Razor view engine
    use {
        'adamclerk/vim-razor',
        ft = {'razor'}
    }

    -- Reason
    use {
        'reasonml-editor/vim-reason-plus',
        ft = {'reason'}
    }

    -- reStructuredText
    use {
        'marshallward/vim-restructuredtext',
        ft = {'rst'}
    }

    -- RSpec
    use {
        'keith/rspec.vim',
        ft = {'rspec'}
    }

    -- RON
    use {
        'ron-rs/ron.vim',
        ft = {'ron'}
    }

    -- Ruby
    use {
        'vim-ruby/vim-ruby',
        ft = {'eruby' ,'ruby'}
    }

    -- Rust
    use {
        'rust-lang/rust.vim',
        ft = {'rust'}
    }

    -- SBT
    use {
        'derekwyatt/vim-sbt',
        ft = {'sbt'}
    }

    -- Scala
    use {
        'derekwyatt/vim-scala',
        ft = {'scala'}
    }

    -- SCSS
    use {
        'cakebaker/scss-syntax.vim',
        ft = {'scss'}
    }

    -- Shell
    use {
        'arzg/vim-sh',
        ft = {'sh'}
    }

    -- Slim
    use {
        'slim-template/vim-slim',
        ft = {'slim'}
    }

    -- Slime
    use {
        'slime-lang/vim-slime-syntax',
        ft = {'slime'}
    }

    -- SML
    use {
        'jez/vim-better-sml',
        ft = {'sml'}
    }

    -- SMT-LIB2
    use {
        'bohlender/vim-smt2',
        ft = {'smt2'}
    }

    -- Solidity
    use {
        'tomlion/vim-solidity',
        ft = {'solidity'}
    }

    -- Starlark
    use {
        'cappyzawa/starlark.vim',
        ft = {'starlark'}
    }

    -- Sugarss
    use {
        'hhsnopek/vim-sugarss',
        ft = {'sugarss'}
    }

    -- Stylus
    use {
        'wavded/vim-stylus',
        ft = {'stylus'}
    }

    -- Svelte
    use {
        'leafOfTree/vim-svelte-plugin',
        ft = {'svelte'},
        config = function()
            vim.cmd [[ let g:vim_svelte_plugin_load_full_syntax = 1 ]]
        end
    }

    -- SVG
    use {
        'jasonshell/vim-svg-indent',
        ft = {'svg'}
    }

    -- SVG
    use {
        'vim-scripts/svg.vim',
        ft = {'svg'}
    }

    -- Swift
    use {
        'keith/swift.vim',
        ft = {'swift'}
    }

    -- Systemd
    use {
        'wgwoods/vim-systemd-syntax',
        ft = {'systemd'}
    }

    -- SXHKD (bspwm)
    use {
        'baskerville/vim-sxhkdrc',
        ft = {'sxhkdrc'}
    }

    -- Terraform
    use {
        'hashivim/vim-terraform',
        ft = {'terraform'}
    }

    -- Textile
    use {
        'timcharper/textile.vim',
        ft = {'textile'}
    }

    -- Thrift
    use {
        'solarnz/thrift.vim',
        ft = {'thrift'}
    }

    -- TomDoc
    use {
        'wellbredgrapefruit/tomdoc.vim',
        ft = {'tomdoc'}
    }

    -- TPTP
    use {
        'c-cube/vim-tptp',
        ft = {'tptp'}
    }

    -- Twig
    use {
        'lumiliet/vim-twig',
        ft = {'twig'}
    }

    -- V
    use {
        'ollykel/v-vim',
        ft = {'v', 'vlang'}
    }

    -- Vala
    use {
        'arrufat/vala.vim',
        ft = {'vala'}
    }

    -- VB.NET
    use {
        'vim-scripts/vbnet.vim',
        ft = {'vb.net'}
    }

    -- VCL
    use {
        'smerrill/vcl-vim-plugin',
        ft = {'vcl'}
    }

    -- Velocity
    use {
        'lepture/vim-velocity',
        ft = {'velocity'}
    }

    -- vifm
    use {
        'vifm/vifm.vim',
        ft = {'vifm', 'vifm-rename'}
    }

    -- VHDL
    use {
        'suoto/vim-hdl',
        ft = {'vhdl'}
    }

    -- Vue
    use {
        'posva/vim-vue',
        ft = {'vue'}
    }

    -- XDC
    use {
        'amal-khailtash/vim-xdc-syntax',
        ft = {'xdc'}
    }

    -- XSL
    use {
        'vim-scripts/XSLT-syntax',
        ft = {'xsl'}
    }

    -- XML
    use {
        'amadeus/vim-xml',
        ft = {'xml'}
    }

    -- YAML
    use {
        'stephpy/vim-yaml',
        ft = {'yaml'}
    }

    -- YANG
    use {
        'nathanalderson/yang.vim',
        ft = {'yang'}
    }

    -- YARD Documentation
    use {
        'sheerun/vim-yardoc',
        ft = {'eruby' ,'ruby'}
    }

    -- Zephir
    use {
        'xwsoul/vim-zephir',
        ft = {'zephir'}
    }

    -- Zig
    use {
        'ziglang/zig.vim',
        ft = {'zig'}
    }

    -- Zinit
    use {
        'zinit-zsh/zinit-vim-syntax',
        ft = {'zsh'}
    }

    -- Zsh
    use {
        'chrisbra/vim-zsh',
        ft = {'zsh'}
    }
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
