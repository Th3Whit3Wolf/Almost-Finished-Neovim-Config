v := "0.2.5"
os := "x86_64-unknown-linux-gnu"

# Install Super Sayain Vim
install: _initialize _venv _web _pack
	#!/bin/bash
	if ! hash cargo 2>/dev/null; then
		echo "Rust installation not found."
		exit 1
	fi
	cargo install --git https://github.com/Th3Whit3Wolf/pquote
	if ! hash node 2>/dev/null; then
		echo "nodejs installation not found."
		exit 1
	fi
	echo "Super Saiyan Vim Installed Sucessfully"

_initialize:
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/backup
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/session
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/swap
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/tags
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/undo
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/venv
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/lsp

_init_pack:
	#!/usr/bin/bash
	if ! hash pack 2>/dev/null; then
		wget https://github.com/maralla/pack/releases/download/v{{v}}/pack-v{{v}}-{{os}}.tar.gz
		tar -vxf pack-v{{v}}-{{os}}.tar.gz
		sudo mv pack /usr/bin/
		sudo rm -dR contrib
		rm LICENSE
		rm pack-v{{v}}-{{os}}.tar.gz
		rm README.md
		echo "export VIM_CONFIG_PATH=$HOME/.cache/vim" >> ~/.zprofile
		VIM_CONFIG_PATH=$HOME/.cache/vim
	elif [[ "$(pack -V | cut -d ' ' -f2 | cut -d '.' -f3)" < "$(echo {{v}} | cut -d '.' -f3)" ]] || [[ "$(pack -V | cut -d ' ' -f2 | cut -d '.' -f2)" < "$(echo {{v}} | cut -d '.' -f2)" ]] || [[ "$(pack -V | cut -d ' ' -f2 | cut -d '.' -f1)" < "$(echo {{v}} | cut -d '.' -f1)" ]]; then
		wget https://github.com/maralla/pack/releases/download/v{{v}}/pack-v{{v}}-{{os}}.tar.gz
		tar -vxf pack-v{{v}}-{{os}}.tar.gz
		sudo mv pack /usr/bin/
		sudo rm -dR contrib
		rm LICENSE
		rm pack-v{{v}}-{{os}}.tar.gz
		rm README.md
	fi

# Update Super Sayain Vim
update:
	@git pull --ff --ff-only
	@pack update

# Same as Update
@upgrade: update

# Unistall Super Sayain Vim
uninstall:
	rm -rf {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim

# Setup Python2 Virtual Environment
venv2:
	#!/usr/bin/env bash
	venv="${XDG_CACHE_HOME:-$HOME/.cache}/vim/venv"
	# Try to detect python2/3 executables
	if ! hash python2 2>/dev/null; then
		echo "Python2 installation not found."
		exit 1
	fi
	# Create Python Virtual Environment
	# Ensure python 2 virtual environments
	[ -d "$venv" ] || mkdir -p "$venv"
	if hash pyenv 2>/dev/null && [ -d "$(pyenv root)/versions/neovim2" ]; then
		# pyenv environments are setup so use them
		[ -d "$venv/neovim2" ] || ln -s "$(pyenv root)/versions/neovim2" "$venv/neovim2"
	else
		[ -d "$venv/neovim2" ] || python2 -m virtualenv "$venv/neovim2"
	fi
	if ! hash python2 2>/dev/null; then
		echo "for Python 2 support install python 2 and python 2 pip and run just venv"
	else
		echo ":: PYTHON 2"
		"$venv/neovim2/bin/pip" install -U \
			pynvim \
			yapf \
			autopep8 \
			pylint \
			flake8 \
			pylama
	fi

# Setup Python3 Virtual Environment
_venv:
	#!/usr/bin/env bash
	venv="${XDG_CACHE_HOME:-$HOME/.cache}/vim/venv"
	if ! hash python3 2>/dev/null; then
		echo "Python3 installation not found."
		exit 1
	fi
	# Create Python Virtual Environment
	# Ensure python 3 virtual environments
	[ -d "$venv" ] || mkdir -p "$venv"
	if hash pyenv 2>/dev/null && [ -d "$(pyenv root)/versions/neovim3" ]; then
		# pyenv environments are setup so use them
		[ -d "$venv/neovim3" ] || ln -s "$(pyenv root)/versions/neovim3" "$venv/neovim3"
	else
		[ -d "$venv/neovim3" ] || python3 -m venv "$venv/neovim3"
	fi

		if ! hash python3 2>/dev/null; then
		echo "for Python 3 support install python 3 and python 3 pip and run just venv"
	else
		echo -e '\n:: PYTHON 3'
		"$venv/neovim3/bin/pip" install -U \
			pynvim \
			yapf \
			autopep8 \
			pylint \
			prospector \
			flake8 \
			pylama \
			mypy \
			mccabe \
			isort \
			jedi \
			rope \
			pycodestyle \
			nodeenv \
			'python-language-server[all]'
	fi

# Install Web
_web:
	#!/usr/bin/env bash
	echo -e '\n:: Nodejs'
	if [ -x "$(command -v yarn)" ]; then
		yarn global add neovim
	elif [ -x "$(command -v npm)" ]; then
		npm install -g neovim
	else
		echo "Please install yarn or npm"
		return 1
	fi
		#$js_install \
		#neovim \
		#bash-language-server \
		#elm \
		# elm-format \
		# elm-test \
		# elm-language-server \
		#eslint \
		#prettier \
		#eslint-config-prettier \
		#eslint-plugin-prettier \
		#ts-node \
		#tslint \
		#typescript \
		#tern \
		#jshint \
		#jsxhint \
		#jsonlint \
		#stylelint \
		#sass-lint \
		#raml-cop \
		#markdownlint-cli \
		#write-good \
		#eslint-cli

# Install all packages
_pack: _init_pack
	#!/usr/bin/bash
	VIM_CONFIG_PATH=$HOME/.cache/vim

	# Lazy Loaded Plugins
	Lazy=(
		"tpope/vim-git"
		"rhysd/committia.vim"
		"mhinz/vim-signify"
		"rhysd/git-messenger.vim"
		"liuchengxu/vim-which-key"
		"Konfekt/FastFold"
		"Konfekt/FoldText"
		"tpope/vim-abolish"
		"tpope/vim-endwise"
		"tpope/vim-eunuch"
		"skywind3000/asyncrun.vim"
		"alvan/vim-closetag"
		"lambdalisue/gina.vim"
		"liuchengxu/vista.vim"
		"ludovicchabant/vim-gutentags"
		"godlygeek/tabular"
		"reedes/vim-wordy"
		"reedes/vim-lexical"
		"reedes/vim-pencil"
		"dbmrq/vim-ditto"
		"sbdchd/neoformat"
		"dense-analysis/ale"
	)
	for i in "${Lazy[@]}"; do
		pack install $i -o
	done

		Filetype=(
		"martinlroth/vim-acpi-asl"                # ACPI ASL
		"pearofducks/ansible-vim"                 # Ansible 2.x
		"sheerun/apiblueprint.vim"                # API Blueprint
		"mityu/vim-applescript"                   # AppleScript
		"sudar/vim-arduino-syntax"                # Arduino
		"asciidoc/vim-asciidoc"                   # AsciiDoc
		"aliou/bats.vim"                          # BATS
		"bazelbuild/vim-bazel"                    # Bazel
		"google/vim-maktaba"                      # Bazel
		"jwalton512/vim-blade"                    # Blade templates
		"bfontaine/Brewfile.vim"                  # Brewfile
		"vim-jp/vim-cpp"                          # C++
		"octol/vim-cpp-enhanced-highlight"        # C++
		"OrangeT/vim-csharp"                      # C#
		"OmniSharp/omnisharp-vim"                 # C#
		"isobit/vim-caddyfile"                    # Caddyfile
		"nastevens/vim-cargo-make"                # Cargo Make (Rust cargo extension)
		"mhinz/vim-crates"                        # Cargo.toml (Rust)
		"hellerve/carp-vim"                       # Carp
		"vadv/vim-chef"                           # Chef
		"mtscout6/vim-cjsx"                       # CJSX (JSX equivalent in CoffeeScript)
		"guns/vim-clojure-static"                 # Clojure
		"tpope/vim-fireplace"                     # Clojure
		"guns/vim-clojure-highlight"              # Clojure
		"pboettch/vim-cmake-syntax"               # Cmake
		"vhdirk/vim-cmake"                        # Cmake
		"kchmck/vim-coffee-script"                # CoffeScript
		"elubow/cql-vim"                          # Cassandra CQL
		"victoredwardocallaghan/cryptol.vim"      # Cryptol
		"vim-crystal/vim-crystal"                 # Crystal
		"hail2u/vim-css3-syntax"                  # CSS
		"chrisbra/csv.vim"                        # CSV
		"tpope/vim-cucumber"                      # Cucumber
		"mgrabovsky/vim-cuesheet"                 # Cue
		"jjaderberg/vim-syntax-cipher"            # Cypher
		"JesseKPhillips/d.vim"                    # D Lang
		"mlr-msft/vim-loves-dafny"                # Dafny
		"dart-lang/dart-vim-plugin"               # Dart
		"vmchale/dhall-vim"                       # Dhall
		"ekalinin/Dockerfile.vim"                 # Dockerfile
		"nastevens/vim-duckscript"                # Duckscript
		"elixir-editors/vim-elixir"               # Elixir
		"yalesov/vim-emblem"				      # Emblem
		"vim-erlang/vim-erlang-runtime"           # Erlang
		"vim-scripts/ferm.vim"                    # Ferm
		"georgewitteman/vim-fish"                 # Fish
		"dcharbon/vim-flatbuffers"                # Flatbuffers
		"kblin/vim-fountain"                      # Fountain
		"calviken/vim-gdscript3"                  # GDScript 3
		"tikhomirov/vim-glsl"                     # OpenGL Shading Language
		"gleam-lang/gleam.vim"                    # Gleam
		"maelvls/gmpl.vim"                        # GMPL
		"vim-scripts/gnuplot-syntax-highlighting" # GNUPlot
		"fatih/vim-go"                            # Go
		"tfnico/vim-gradle"                       # Gradle
		"jparise/vim-graphql"                     # GraphQL
		"hhvm/vim-hack"                           # Hack
		"sheerun/vim-haml"                        # Haml
		"mustache/vim-mustache-handlebars"        # Handlebars
		"CH-DanReif/haproxy.vim"                  # HAProxy
		"neovimhaskell/haskell-vim"               # Haskel
		"yaymukund/vim-haxe"                      # Haxe
		"b4b4r07/vim-hcl"                         # HCL
		"towolf/vim-helm"                         # Helm Templates
		"zebradil/hive.vim"                       # Hive
		"othree/html5.vim"                        # HTML5
		"mboughaba/i3config.vim"                  # i3
		"chutzpah/icalendar.vim"                  # icalendar
		"idris-hackers/idris-vim"                 # Idris
		"HiPhish/info.vim"                        # Info
		"vmchale/ion-vim"                         # Ion
		"jez/vim-ispc"                            # ISPC
		"pangloss/vim-javascript"                 # Javascript
		"briancollins/vim-jst"                    # JST
		"maxmellon/vim-jsx-pretty"                # JSX
		"martinda/Jenkinsfile-vim-syntax"         # Jenkins
		"lepture/vim-jinja"                       # Jinja
		"elzr/vim-json"                           # Json
		"GutenYe/json5.vim"                       # Json5
		"JuliaEditorSupport/julia-vim"            # Julia
		"udalov/kotlin-vim"                       # Kotlin
		"lervag/vimtex"                           # Latex
		"xuhdev/vim-latex-live-preview"           # Latex
		"ledger/vim-ledger"                       # Ledger
		"groenewege/vim-less"                     # Less
		"sersorrel/vim-lilypond"                  # Lilypond
		"gkz/vim-ls"                              # LiveScript
		"MTDL9/vim-log-highlighting"              # Log
		"tbastos/vim-lua"                         # Lua
		"jstrater/mpvim"                          # Macports
		"sophacles/vim-bundle-mako"               # Mako
		"plasticboy/vim-markdown"                 # Markdown
		"rhysd/vim-gfm-syntax"                    # Markdown (github)
		"voldikss/vim-mma"                        # Mathematica
		"daeyun/vim-matlab"                       # Matlab
		"jxnblk/vim-mdx-js"                       # MDX
		"stewy33/mercury-vim"                     # Mercury
		"leafo/moonscript-vim"                    # MoonScript
		"chr4/nginx.vim"                          # Nginx
		"zah/nim.vim"                             # Nim
		"LnL7/vim-nix"                            # Nix
		"b4winckler/vim-objc"                     # Objective-C
		"ocaml/vim-ocaml"                         # OCaml
		"McSinyx/vim-octave"                      # Octave
		"mcnelson/vim-pawn"                       # Pawn
		"vim-pandoc/vim-pandoc"                   # Pandoc
		"vim-pandoc/vim-pandoc-syntax"            # Pandoc
		"vim-perl/vim-perl"                       # PERL
		"lifepillar/pgsql.vim"                    # PostgreSQL
		"StanAngeloff/php.vim"                    # PHP
		"aklt/plantuml-syntax"                    # PlantUML
		"jakwings/vim-pony"                       # Ponylang
		"PProvost/vim-ps1"                        # PowerShell
		"adimit/prolog.vim"                       # Prolog
		"uarun/vim-protobuf"                      # Protocol Buffers
		"digitaltoad/vim-pug"                     # Pug template
		"rodjek/vim-puppet"                       # Puppet
		"purescript-contrib/purescript-vim"       # PureScript
		"vim-python/python-syntax"                # Python
		"Vimjas/vim-python-pep8-indent"           # Python
		"artoj/qmake-syntax-vim"                  # QMake
		"peterhoeg/vim-qml"                       # QML
		"jalvesaq/Nvim-R"                         # R
		"wlangstroth/vim-racket"                  # Racket
		"jneen/ragel.vim"                         # Ragel
		"Raku/vim-raku"                           # Raku
		"IN3D/vim-raml"                           # RAML
		"adamclerk/vim-razor"                     # Razor view engine
		"reasonml-editor/vim-reason-plus"         # Reason
		"keith/rspec.vim"                         # RSpec
		"marshallward/vim-restructuredtext"       # reStructuredText
		"vim-ruby/vim-ruby"                       # Ruby
		"rust-lang/rust.vim"                      # Rust
		"arzg/vim-rust-syntax-ext"                # Rust
		"derekwyatt/vim-sbt"                      # SBT
		"derekwyatt/vim-scala"                    # Scala
		"cakebaker/scss-syntax.vim"               # SCSS
		"arzg/vim-sh"                             # Shell
		"slim-template/vim-slim"                  # Slim
		"slime-lang/vim-slime-syntax"             # Slime
		"jez/vim-better-sml"                      # SML
		"bohlender/vim-smt2"                      # SMT-LIB2
		"tomlion/vim-solidity"                    # Solidity
		"tpope/vim-dotenv"                        # SQl
		"tpope/vim-dadbod"                        # SQl
		"kristijanhusak/vim-dadbod-completion"    # SQl
		"kristijanhusak/vim-dadbod-ui"            # SQl
		"cappyzawa/starlark.vim"                  # Starlark
		"hhsnopek/vim-sugarss"                    # Sugarss
		"wavded/vim-stylus"                       # Stylus
		"leafOfTree/vim-svelte-plugin"            # Svelte
		"jasonshell/vim-svg-indent"               # SVG
		"vim-scripts/svg.vim"                     # SVG
		"keith/swift.vim"                         # Swift
		"wgwoods/vim-systemd-syntax"              # Systemd
		"baskerville/vim-sxhkdrc"                 # SXHKD (bspwm)
		"hashivim/vim-terraform"                  # Terraform
		"timcharper/textile.vim"                  # Textile
		"solarnz/thrift.vim"                      # Thrift
		"ericpruitt/tmux.vim"                     # Tmux
		"wellbredgrapefruit/tomdoc.vim"           # TomDoc
		"cespare/vim-toml"                        # TOML
		"c-cube/vim-tptp"                         # TPTP
		"lumiliet/vim-twig"                       # Twig
		"HerringtonDarkholme/yats.vim"            # TypeScript
		"ollykel/v-vim"                           # V
		"arrufat/vala.vim"                        # Vala
		"vim-scripts/vbnet.vim"                   # VB.NET
		"smerrill/vcl-vim-plugin"                 # VCL
		"lepture/vim-velocity"                    # Velocity
		"vifm/vifm.vim"                           # vifm
		"suoto/vim-hdl"                           # VHDL
		"posva/vim-vue"                           # Vue
		"amal-khailtash/vim-xdc-syntax"           # XDC
		"vim-scripts/XSLT-syntax"                 # XSL
		"amadeus/vim-xml"                         # XML
		"stephpy/vim-yaml"                        # YAML
		"nathanalderson/yang.vim"                 # YANG
		"sheerun/vim-yardoc"                      # YARD Documentation
		"xwsoul/vim-zephir"                       # Zephir
		"ziglang/zig.vim"                         # Zig
		"zinit-zsh/zinit-vim-syntax"              # Zinit
		"chrisbra/vim-zsh"                        # Zsh
	)
	for i in "${Filetype[@]}"; do
		pack install $i -o
	done

	Normal=(
		"liuchengxu/vim-clap"
		"ryanoasis/vim-devicons"
		"hardcoreplayers/dashboard-nvim"
		"tpope/vim-commentary"
		"tpope/vim-surround"
		"honza/vim-snippets"
	)
	nm=$(printf " %s" "${Normal[@]}")
	nm=${nm:1}
	pack install $nm

	pack install neoclide/coc.nvim --build 'git checkout release'
	pack install alok/rainbow_parentheses.vim --build 'git checkout fix-spell' -o
	pack install euclio/vim-markdown-composer --build 'cargo build --release' -o
	pack install turbio/bracey.vim --build 'yarn --prefix server' -o
	pack install heavenshell/vim-jsdoc --build 'make clean && make install' -o

	# Build Clap with maple
	nvim -c 'call clap#installer#build_all() | q'
