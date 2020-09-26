local home = os.getenv("HOME")
local global = require 'settings/global'

plug = {}

function Split(s, delimiter)
    result = {};
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match);
    end
    return result;
end

local normal_plugins = {"jiangmiao/auto-pairs", -- Vim plugin, insert or delete brackets, parens, quotes in pair 
"tpope/vim-dadbod", -- plugin for interacting with databases
"kristijanhusak/vim-dadbod-ui", -- Like pgadmin but for vim
"glepnir/spaceline.vim", -- Most beautiful & fastest statusline
"ryanoasis/vim-devicons", -- Devicons (requirement for spaceline)
"hardcoreplayers/dashboard-nvim" -- Modern vim-startify
}

local lua_plugins = {"neovim/nvim-lspconfig", -- Collection of common configurations for the Nvim LSP client.
"tjdevries/lsp_extensions.nvim", -- bunch of info & extension callbacks for built-in LSP (provides inlay hints)
"nvim-lua/completion-nvim", -- auto completion framework that aims to provide a better completion experience with neovim's built-in LSP
"nvim-lua/diagnostic-nvim", -- wrapsthe diagnostics setting to make it more user friendly
"nvim-treesitter/nvim-treesitter", -- Treesitter configurations and abstraction layer for Neovim. 
"nvim-treesitter/completion-treesitter", -- treesitter based completion sources.
"steelsojka/completion-buffers", -- completion for buffers word.
"kristijanhusak/vim-dadbod-completion", -- completion sources for vim-dadbod
"kristijanhusak/completion-tags", -- Slightly improved ctags completion
"kyazdani42/nvim-web-devicons", -- devicons in lua
"kyazdani42/nvim-tree.lua", -- A File Explorer For Neovim Written In Lua
"tjdevries/colorbuddy.nvim", -- A colorscheme helper for Neovim
"norcalli/snippets.nvim", -- Snippets tool written in lua
"norcalli/nvim-colorizer.lua", -- high-performance color highlighter for Neovim
"mhartington/formatter.nvim" -- A format runner for neovim, written in lua
}

local lazy_plugins = {"tpope/vim-eunuch", -- Vim sugar for the UNIX shell commands
"rhysd/committia.vim", -- improves the git commit buffer
"tpope/vim-git", -- Vim Git runtime files
"mhinz/vim-signify", -- uses the sign column to indicate added, modified and removed lines in a file that is managed by a version control system
"rhysd/git-messenger.vim", -- shows the history of commits under the cursor in popup window
"liuchengxu/vim-which-key", -- Vim plugin that shows keybindings in popup 
"tpope/vim-abolish", -- easily search for, substitute, and abbreviate multiple variants of a word 
"alvan/vim-closetag", -- Auto close (X)HTML tags 
"lambdalisue/gina.vim", -- Asynchronously control git repositories in Neovim
"liuchengxu/vista.vim", -- Viewer & Finder for LSP symbols and tags
"godlygeek/tabular", -- Vim script for text filtering and alignment 
"reedes/vim-wordy", -- Uncover usage problems in your writing
"reedes/vim-lexical", -- Building on Vim’s spell-check and thesaurus/dictionary completion
"reedes/vim-pencil", -- handful of tweaks needed to smooth the path to writing prose
"dbmrq/vim-ditto" -- highlights overused words
}

local ft_plugins = {"martinlroth/vim-acpi-asl", -- ACPI ASL
"pearofducks/ansible-vim", -- Ansible 2.x
"sheerun/apiblueprint.vim", -- API Blueprint
"mityu/vim-applescript", -- AppleScript
"sudar/vim-arduino-syntax", -- Arduino
"asciidoc/vim-asciidoc", -- AsciiDoc
"aliou/bats.vim", -- BATS
"bazelbuild/vim-bazel", -- Bazel
"google/vim-maktaba", -- Bazel
"jwalton512/vim-blade", -- Blade templates
"bfontaine/Brewfile.vim", -- Brewfile
"vim-jp/vim-cpp", -- C++
"octol/vim-cpp-enhanced-highlight", -- C++
"OrangeT/vim-csharp", -- C#
"OmniSharp/omnisharp-vim", -- C#
"isobit/vim-caddyfile", -- Caddyfile
"nastevens/vim-cargo-make", -- Cargo Make (Rust cargo extension)
"mhinz/vim-crates", -- Cargo.toml (Rust)
"hellerve/carp-vim", -- Carp
"vadv/vim-chef", -- Chef
"mtscout6/vim-cjsx", -- CJSX (JSX equivalent in CoffeeScript)
"guns/vim-clojure-static", -- Clojure
"tpope/vim-fireplace", -- Clojure
"guns/vim-clojure-highlight", -- Clojure
"pboettch/vim-cmake-syntax", -- Cmake
"vhdirk/vim-cmake", -- Cmake
"kchmck/vim-coffee-script", -- CoffeScript
"elubow/cql-vim", -- Cassandra CQL
"victoredwardocallaghan/cryptol.vim", -- Cryptol
"vim-crystal/vim-crystal", -- Crystal
"hail2u/vim-css3-syntax", -- CSS
"chrisbra/csv.vim", -- CSV
"tpope/vim-cucumber", -- Cucumber
"mgrabovsky/vim-cuesheet", -- Cue
"jjaderberg/vim-syntax-cipher", -- Cypher
"JesseKPhillips/d.vim", -- D Lang
"mlr-msft/vim-loves-dafny", -- Dafny
"dart-lang/dart-vim-plugin", -- Dart
"vmchale/dhall-vim", -- Dhall
"ekalinin/Dockerfile.vim", -- Dockerfile
"nastevens/vim-duckscript", -- Duckscript
"elixir-editors/vim-elixir", -- Elixir
"yalesov/vim-emblem", -- Emblem
"vim-erlang/vim-erlang-runtime", -- Erlang
"bakpakin/fennel.vim", -- Fennel
"vim-scripts/ferm.vim", -- Ferm
"georgewitteman/vim-fish", -- Fish
"dcharbon/vim-flatbuffers", -- Flatbuffers
"kblin/vim-fountain", -- Fountain
"calviken/vim-gdscript3", -- GDScript 3
"tikhomirov/vim-glsl", -- OpenGL Shading Language
"gleam-lang/gleam.vim", -- Gleam
"maelvls/gmpl.vim", -- GMPL
"vim-scripts/gnuplot-syntax-highlighting", -- GNUPlot
"fatih/vim-go", -- Go
"tfnico/vim-gradle", -- Gradle
"jparise/vim-graphql", -- GraphQL
"hhvm/vim-hack", -- Hack
"sheerun/vim-haml", -- Haml
"mustache/vim-mustache-handlebars", -- Handlebars
"CH-DanReif/haproxy.vim", -- HAProxy
"neovimhaskell/haskell-vim", -- Haskel
"yaymukund/vim-haxe", -- Haxe
"b4b4r07/vim-hcl", -- HCL
"towolf/vim-helm", -- Helm Templates
"zebradil/hive.vim", -- Hive
"othree/html5.vim", -- HTML5
"mboughaba/i3config.vim", -- i3
"chutzpah/icalendar.vim", -- icalendar
"idris-hackers/idris-vim", -- Idris
"HiPhish/info.vim", -- Info
"vmchale/ion-vim", -- Ion
"jez/vim-ispc", -- ISPC
"pangloss/vim-javascript", -- Javascript
"briancollins/vim-jst", -- JST
"maxmellon/vim-jsx-pretty", -- JSX
"martinda/Jenkinsfile-vim-syntax", -- Jenkins
"lepture/vim-jinja", -- Jinja
"elzr/vim-json", -- Json
"GutenYe/json5.vim", -- Json5
"JuliaEditorSupport/julia-vim", -- Julia
"udalov/kotlin-vim", -- Kotlin
"lervag/vimtex", -- Latex
"xuhdev/vim-latex-live-preview", -- Latex
"ledger/vim-ledger", -- Ledger
"groenewege/vim-less", -- Less
"sersorrel/vim-lilypond", -- Lilypond
"gkz/vim-ls", -- LiveScript
"MTDL9/vim-log-highlighting", -- Log
"tbastos/vim-lua", -- Lua
"jstrater/mpvim", -- Macports
"sophacles/vim-bundle-mako", -- Mako
"plasticboy/vim-markdown", -- Markdown
"rhysd/vim-gfm-syntax", -- Markdown (github)
"voldikss/vim-mma", -- Mathematica
"daeyun/vim-matlab", -- Matlab
"jxnblk/vim-mdx-js", -- MDX
"stewy33/mercury-vim", -- Mercury
"leafo/moonscript-vim", -- MoonScript
"chr4/nginx.vim", -- Nginx
"zah/nim.vim", -- Nim
"LnL7/vim-nix", -- Nix
"b4winckler/vim-objc", -- Objective-C
"ocaml/vim-ocaml", -- OCaml
"McSinyx/vim-octave", -- Octave
"mcnelson/vim-pawn", -- Pawn
"vim-pandoc/vim-pandoc", -- Pandoc
"vim-pandoc/vim-pandoc-syntax", -- Pandoc
"vim-perl/vim-perl", -- PERL
"lifepillar/pgsql.vim", -- PostgreSQL
"StanAngeloff/php.vim", -- PHP
"aklt/plantuml-syntax", -- PlantUML
"jakwings/vim-pony", -- Ponylang
"PProvost/vim-ps1", -- PowerShell
"adimit/prolog.vim", -- Prolog
"uarun/vim-protobuf", -- Protocol Buffers
"digitaltoad/vim-pug", -- Pug template
"rodjek/vim-puppet", -- Puppet
"purescript-contrib/purescript-vim", -- PureScript
"vim-python/python-syntax", -- Python
"Vimjas/vim-python-pep8-indent", -- Python
"artoj/qmake-syntax-vim", -- QMake
"peterhoeg/vim-qml", -- QML
"jalvesaq/Nvim-R", -- R
"wlangstroth/vim-racket", -- Racket
"jneen/ragel.vim", -- Ragel
"Raku/vim-raku", -- Raku
"IN3D/vim-raml", -- RAML
"adamclerk/vim-razor", -- Razor view engine
"reasonml-editor/vim-reason-plus", -- Reason
"keith/rspec.vim", -- RSpec
"marshallward/vim-restructuredtext", -- reStructuredText
"vim-ruby/vim-ruby", -- Ruby
"rust-lang/rust.vim", -- Rust
"arzg/vim-rust-syntax-ext", -- Rust
"derekwyatt/vim-sbt", -- SBT
"derekwyatt/vim-scala", -- Scala
"cakebaker/scss-syntax.vim", -- SCSS
"arzg/vim-sh", -- Shell
"slim-template/vim-slim", -- Slim
"slime-lang/vim-slime-syntax", -- Slime
"jez/vim-better-sml", -- SML
"bohlender/vim-smt2", -- SMT-LIB2
"tomlion/vim-solidity", -- Solidity
"tpope/vim-dotenv", -- SQl
"tpope/vim-dadbod", -- SQl
"kristijanhusak/vim-dadbod-completion", -- SQl
"kristijanhusak/vim-dadbod-ui", -- SQl
"cappyzawa/starlark.vim", -- Starlark
"hhsnopek/vim-sugarss", -- Sugarss
"wavded/vim-stylus", -- Stylus
"leafOfTree/vim-svelte-plugin", -- Svelte
"jasonshell/vim-svg-indent", -- SVG
"vim-scripts/svg.vim", -- SVG
"keith/swift.vim", -- Swift
"wgwoods/vim-systemd-syntax", -- Systemd
"baskerville/vim-sxhkdrc", -- SXHKD (bspwm)
"hashivim/vim-terraform", -- Terraform
"timcharper/textile.vim", -- Textile
"solarnz/thrift.vim", -- Thrift
"ericpruitt/tmux.vim", -- Tmux
"wellbredgrapefruit/tomdoc.vim", -- TomDoc
"cespare/vim-toml", -- TOML
"c-cube/vim-tptp", -- TPTP
"lumiliet/vim-twig", -- Twig
"HerringtonDarkholme/yats.vim", -- TypeScript
"ollykel/v-vim", -- V
"arrufat/vala.vim", -- Vala
"vim-scripts/vbnet.vim", -- VB.NET
"smerrill/vcl-vim-plugin", -- VCL
"lepture/vim-velocity", -- Velocity
"vifm/vifm.vim", -- vifm
"suoto/vim-hdl", -- VHDL
"posva/vim-vue", -- Vue
"amal-khailtash/vim-xdc-syntax", -- XDC
"vim-scripts/XSLT-syntax", -- XSL
"amadeus/vim-xml", -- XML
"stephpy/vim-yaml", -- YAML
"nathanalderson/yang.vim", -- YANG
"sheerun/vim-yardoc", -- YARD Documentation
"xwsoul/vim-zephir", -- Zephir
"ziglang/zig.vim", -- Zig
"zinit-zsh/zinit-vim-syntax", -- Zinit
"chrisbra/vim-zsh" -- Zsh
}

local build_plugins = {
    ["alok/rainbow_parentheses.vim"] = "git checkout fix-spell",
    ["turbio/bracey.vim"] = "yarn --prefix server",
    ["euclio/vim-markdown-composer"] = "cargo build --release",
    ["heavenshell/vim-jsdoc"] = "make clean && make install"
}

function plug.install_default()
    local pack = home .. '/.cargo/bin/npack'
    local opt_plugins = {}

    for _, v in pairs(lua_plugins) do
        table.insert(opt_plugins, v)
    end
    for _, v in pairs(lazy_plugins) do
        table.insert(opt_plugins, v)
    end
    for _, v in pairs(ft_plugins) do
        table.insert(opt_plugins, v)
    end

    if not global.exists(pack) then
        os.execute("cargo install --git https://github.com/Th3Whit3Wolf/neopack.git")
    end

    if global.exists(pack) then
        for _, plugin in ipairs(opt_plugins) do
            if not global.exists(global.plugins .. 'opt/' .. Split(plugin, '/')[2]) then
                vim.cmd("silent !npack install " .. plugin .. " -o")
                if Split(plugin, '/')[2] == 'nvim-treesitter' then
                    vim.cmd('TSInstall all')
                end
            end
        end
        for _, plugin in ipairs(normal_plugins) do
            if not global.exists(global.plugins .. 'start/' .. Split(plugin, '/')[2]) then
                vim.cmd("silent !npack install " .. plugin)
            end
        end
        for plugin, build_cmd in ipairs(build_plugins) do
            if not global.exists(global.plugins .. 'opt/' .. Split(plugin, '/')[2]) then
                vim.cmd("silent !npack " .. plugin .. " --build '" .. build_cmd .. "' -o")
            end
        end
    end

    print('All default plugins installed')
end

function plug.load_lua()
    for _, plugins in ipairs(lua_plugins) do
        local plugin = Split(plugins, '/')[2]
        -- Actual lazy loaded lua plugins
        if plugin ~= 'nvim-treesitter' or plugin ~= 'completion-treesitter' or plugin ~= 'completion-tags' then
            vim.cmd('packadd ' .. plugin)
        end
    end
end

function plug.install( arg )
    local plugin = Split(arg, ' ')[1]
    if string.match(arg, "-o") then
        if not global.exists(global.plugins .. 'opt/' .. Split(plugin, '/')[2]) then
            vim.cmd("silent !npack install " .. plugin .. " -o")
        end
    else
        if not global.exists(global.plugins .. 'start/' .. Split(plugin, '/')[2]) then
            vim.cmd("silent !npack install " .. plugin)
        end
    end
    print('Installed '.. Split(plugin, '/')[2])
end

return plug
