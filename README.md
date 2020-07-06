# Almost Finished Neovim Config

Fast and full featured neovim config that leans heavily on the neovims builtin package feature and
modular file structure. Lazy loading where it makes sense.

<details>
  <summary>
    <strong>Table of Contents</strong>
    <small><i>(🔎 Click to expand/collapse)</i></small>
  </summary>

- [Almost Finished Neovim Config](#almost-finished-neovim-config)
  - [Features](#features)
  - [Screenshots](#screenshots)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Upgrade](#upgrade)
    - [Recommended Fonts](#recommended-fonts)
      - [Terminals that support font ligatures](#terminals-that-support-font-ligatures)
      - [Why use ligatures](#why-use-ligatures)
    - [Recommended Tools](#recommended-tools)
  - [Structure](#structure)
  - [Plugin Highlights](#plugin-highlights)
  - [Features In-depth](#features-in-depth)
    - [Auto Shebang](#auto-shebang)
      - [Shebangs](#shebangs)
    - [Code Compile](#code-compile)
    - [Code Runner](#code-runner)
    - [Code Tester](#code-tester)
  - [Plugins Included](#plugins-included)
    - [Non Lazy-Loaded Plugins](#non-lazy-loaded-plugins)
    - [Lazy-Loaded Plugins](#lazy-loaded-plugins)
      - [Language](#language)
      - [Interface](#interface)
      - [Completion & Code-Analysis](#completion--code-analysis)
      - [Command](#command)
  - [Custom Mappings](#custom-mappings)
    - [Leader Key Mappings](#leader-key-mappings)
      - [Navigation](#navigation)
      - [File Operations](#file-operations)
      - [Edit](#edit)
      - [Search & Replace](#search--replace)
      - [Clipboard](#clipboard)
      - [Command & History](#command--history)
      - [Editory UI](#editory-ui)
      - [Custom Tools & Plugins](#custom-tools--plugins)
      - [Window Management](#window-management)
      - [Git Version Control](#git-version-control)
  - [Credits](#credits)

</details>

## Features

- Fast startup time, 27-40ms
- Robust, yet light-weight
- Lazy Load 85% of plugins (71/84)
- Ultimate Linting, Code Formating, & Language Support
- Central location for tags
- Awesome Dashboard(thanks to [dashboard.nvim](https://github.com/hardcoreplayers/dashboard-nvim/blob/master/plugin/dashboard.vim))
- Auto Shebang
- Code Runner, Compiler, & Tester
- Can determine filetype for files with no extensions(via shebang)
- Lazygit integration
- Light & Dark Mode
- Automatically changes colors at night
- Automatically adds in pairs (parentheses, brackets, curly brace) and ends (end, endif, fi, etc)

## Screenshots

**NOTE:** My desktop dims inactive window, light theme is actually lighter

![Dashboard](./assets/ScreenShot_Dashboard.png)

![Bash](./assets/ScreenShot_Bash.png)

## Prerequisites

- Python 3
- Rust (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)
- Neovim
- [Just](https://github.com/casey/just)
- yarn (for coc.vim)
- Your Compiler and/or Interpreter
- Your favorite Language Servers, Linters, and/or Code Formatters

## Install

[1.] Let's clone this repo! Clone to `~/.config/nvim`,
we'll also symlink it for Vim:

```sh
mkdir ~/.config
git clone https://github.com/Th3Whit3Wolf/Almost-Finished-Neovim-Config.git ~/.config/nvim
cd ~/.config/nvim
ln -s ~/.config/nvim ~/.vim  # For Vim8, although no promises on this working with vim
just install
```

If you do web development you may also want to run `just web` for linters, formatters, and spell checker.

* _**Note:**_ If your system sets `$XDG_CONFIG_HOME`,
  use that instead of `~/.config` in the code above.
  Nvim follows the XDG base-directories convention.

[1.] Install extensions from below to get better autocompletion and linting

Enjoy!

## Upgrade

```sh
just upgrade
```

### Recommended Fonts

| Ligature Fonts    | No Ligatures but Awesome |
| ----------------- | ------------------------ |
| [Fira Code](https://github.com/tonsky/FiraCode) (free) |  [IBM Plex Mono](https://github.com/IBM/plex) (free) |
| [Hasklig](https://github.com/i-tu/Hasklig) (free) | [Hack](https://sourcefoundry.org/hack/) (free)** |
| [PragmataPro](http://www.fsd.it/fonts/pragmatapro.htm) (€59) | [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/) (free) |
| [Monoid](http://larsenwork.com/monoid/) (free) | [Menlo](https://www.typewolf.com/site-of-the-day/fonts/menlo) (free)     |
| [Fixedsys Excelsior](https://github.com/kika/fixedsys) (free) | [Monaco](https://gist.github.com/rogerleite/99819) (free)    |
| [Iosevka](https://be5invis.github.io/Iosevka/) (free) |     |
| [DejaVu Sans Code](https://github.com/SSNikolaevich/DejaVuSansCode) (free) |        |
| [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) | |

#### Terminals that support font ligatures

| Works              | Doesn’t work       |
| ------------------ | ------------------ |
| Butterfly      | Alacritty      |
| Hyper.app      | cmd.exe        |
| iTerm 2 ([since 3.1](https://gitlab.com/gnachman/iterm2/issues/3568#note_13118332)) | Cmder |
| Kitty          | ConEmu         |
| Konsole        | GNOME Terminal |
| QTerminal      | mate-terminal  |
| Terminal.app   | mintty         |
| Termux         | PuTTY          |
| Token2Shell/MD | rxvt           |
| upterm         | ZOC (Windows)  |
| ZOC (macOS)    | libvte-based terminals ([bug report](https://bugzilla.gnome.org/show_bug.cgi?id=584160)) |

#### Why use ligatures

So This..

<img src="https://raw.githubusercontent.com/i-tu/Hasklig/master/SourceCodeProSample.png">

Looks Like This

<img src="https://raw.githubusercontent.com/i-tu/Hasklig/master/hasklig_example.png">

### Recommended Tools

* [ripgrep](https://github.com/BurntSushi/ripgrep)

  * Faster grepping (also used by vim-clap)

* [fzy](https://github.com/jhawthorn/fzy)

  * Used by vim-claps

* [sk](https://github.com/lotabout/skim)

  * Used by vim-clap

* [fd](https://github.com/sharkdp/fd)

  * Used by vim-clap

* [Universal ctags](https://ctags.io/)
  * for syntax tokenization

- [Lazy Git](https://github.com/jesseduffield/lazygit)

  - Simple terminal UI for git commands
  - Makes using git insanely easy

- [zoxide](https://github.com/ajeetdsouza/zoxide)
  - zoxide is a blazing fast alternative to cd, inspired by z and z.lua.
  - It keeps track of the directories you use most frequently, and uses a ranking algorithm to navigate to the best match.

## Structure

```sh
    .
    ├── after
    │   └── plugin   # Get loaded after plugin
    ├── autoload     # Get loaded automatically
    ├── colors       # Colorscheme
    ├── ftdetect     # Identifies filetypes
    ├── ftplugin     # Filetype specific and loaded on filetype
    ├── lazy         # Configs for lazy loaded plugins
    ├── plugin       # Plugins loaded automatically
    ├ init.vim       # Configuration
    └ function.vim   # Convenience functions
```

## Plugin Highlights

- Plugin managed outside of vim (can automate plugin updates) and lazy loading for speed
- Auto-completion with Language-Server Protocol (LSP)
- Code Compiler, Runner, & Tester builtin
- Coc-Explorer as file-manager

## Features In-depth

<details open>
  <summary><strong>List</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

### Auto Shebang

When creating a new shell or python neovim will prompt you for what shebang you would like to use. It is automatic for escript, fish, ion, lua, perl, php, & ruby.

You can press <kbd>space</kbd>+<kbd>cs</kbd> to change shebangs

#### Shebangs

**Awk**

`#!/usr/bin/env awk`

**Escript**

`#!/usr/bin/env escript`

**Fish**

`#!/usr/bin/env fish`

**Ion**

`#!/usr/bin/env ion`

**Julia**

`#!/usr/bin/env julia`

**Lua**

`#!/usr/bin/env lua`

**Perl**

`#!/usr/bin/env perl`

**PHP**

`#!/usr/bin/env php`

**Python**

* python2 - `#!/usr/bin/env python2`
* python3 - `#!/usr/bin/env python2`
* pypy     - `#!/usr/bin/env pypy`
- pypy3    - `#!/usr/bin/env pypy3`
- jython  - `#!/usr/bin/env jython`

**Ruby**

`#!/usr/bin/env ruby`

**Scala**

`#!/usr/bin/env scala`

**Shell**

- ash   - `#!/usr/bin/env ash`
- bash  - `#!/usr/bin/env bash`
- csh   - `#!/usr/bin/env csh`
- dash  - `#!/usr/bin/env dash`
- fish  - `#!/usr/bin/env fish`
- ksh   - `#!/usr/bin/env ksh`
- ion   - `#!/usr/bin/env ion`
- mksh  - `#!/usr/bin/env mksh`
- dksh  - `#!/usr/bin/env pdksh`
- tcsh  - `#!/usr/bin/env tcsh`
- zsh   - `#!/usr/bin/env zsh`

### Code Compile

| Language | Requirements | Action |
| -------- | ------------ | ------ |
| C     | gcc | Compiles binary to filename without extensions |
| C++     | g++ | Compiles binary to filename without extensions |
| Go     | go | Runs go build |

### Code Runner

| Language | Requirements | Action |
| -------- | ------------ | ------ |
| C        | gcc | Compiles binary and executes |
| C++      | g++ | Compiles binary and executes |
| Go       | go | Runs go run |

### Code Tester

| Language | Requirements | Action |
| -------- | ------------ | ------ |
| Rust     | Inside of Cargo Project | Runs test with one thread and shows output of test |

</details>

## Plugins Included

<details open>
  <summary><strong>List</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

### Non Lazy-Loaded Plugins

| Name | Description |
| ---- | ----------- |
| [vim-buffet](https://github.com/bagrat/vim-buffet)  |               |
| [vim-clap](https://github.com/liuchengxu/vim-clap) | |
| [vim-devicons](https://github.com/ryanoasis/vim-devicons) |
| [vim-shebang](https://github.com/Th3Whit3Wolf/vim-shebang) | |
| [dashboard-nvim](https://github.com/hardcoreplayers/dashboard-nvim) ||
| [FastFold](https://github.com/Konfekt/FastFold) ||
| [vim-commentary](https://github.com/tpope/vim-commentary) ||
| [vim-surround](https://github.com/tpope/vim-surround) ||
| [vim-endwise](https://github.com/tpope/vim-endwise) ||
| [vim-snippets](https://github.com/honza/vim-snippets) ||
| [vim-which-key](https://github.com/liuchengxu/vim-which-key) ||
| [coc.nvim](https://github.com/neoclide/coc.nvim) ||
| [Spaceline.vim](https://github.com/hardcoreplayers/spaceline.vim) ||

### Lazy-Loaded Plugins

#### Language

| Name | Description |
| ---- | ----------- |
| [rust-vim](https://github.com/rust-lang/rust.vim) | Rust Support |
| [vim-rust-syntax-ext](https://github.com/arzg/vim-rust-syntax-ext) | Extend Rust Syntax |
| [vim-go](https://github.com/faith/vim-go) | Go Support |
| [vim-toml](cespare/vim-toml) | Syntax for TOML |
| [vim-crates](https://github.com/mhinz/vim-crates)| Makes updating `Cargo.toml` a breeze |
| [vim-eunuch](https://github.com/tpope/vim-eunuch) | Makes it easier to use unix commands from vm|

#### Interface

| Name | Description |
| ---- | ----------- |
| [vim-FoldText](https://github.com/Konfekt/FoldText)||
| [vim-closetag](https://github.com/alvan/vim-closetag) ||
| [vim-signify](https://github.com/mhinz/vim-signify) | |
| [vista.vim](https://github.com/liuchengxu/vista.vim)||
| [rainbow_parentheses.vim](https://github.com/alok/rainbow_parentheses.vim)||
| [git-messenger.vim](https://github.com/rhysd/git-messenger.vim) ||

#### Completion & Code-Analysis

| Name | Description |
| ---- | ----------- |
| [vim-markdown-composer](https://github.com/euclio/vim-markdown-composer)||
| [bracey.vim](https://github.com/turbio/bracey.vim)||
| [asyncrun](https://github.com/skywind3000/asyncrun.vim) ||
| [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags) | Manages your tag files |
| [vim-abolish](https://github.com/tpope/vim-abolish) ||

#### Command

| Name | Description |
| ---- | ----------- |
| [vim-eunuch](https://github.com/tpope/vim-eunuch) | Makes it easier to use unix commands in vim|
| [vim-startuptime](https://github.com/dstein64/vim-startuptime) | Visually profile Vim's startup time |
| [gina.vim](https://github.com/lambdalisue/gina.vim) ||
| [committia.vim](https://github.com/rhysd/committia.vim) ||

</details>

## Custom Mappings

Note that,

Leader key set as <kbd>Space</kbd>

<details open>
  <summary><strong>Key Mappings</strong> <small><i>(🔎 Click to expand/collapse)</i></small></summary>

Modes: 𝐍=normal 𝐕=visual 𝐒=select 𝐈=insert 𝐂=command

### Leader Key Mappings

#### Navigation

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### File Operations

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Edit

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Search & Replace

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Clipboard

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Command & History

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Editory UI

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Custom Tools & Plugins

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Window Management

| Key | 	Mode |	Action |	Plugin or Mapping |
| ---- | --- | ---- |
| | | | |

#### Git Version Control

| Key | 	Mode |	Action |	Plugin or Mapping |
| ----------------------------------------- | ------------ |
| <kbd>Space</kbd>+<kbd>gm</kbd> | *N*  | Show git blame of line under cursor in preview window |GitMessenger |

</details>

## Credits

I owe a special thanks to the following projects:

- [Pack](https://github.com/maralla/pack) - Package Manager that works outside of vim

  - This config is designed to utilize neovim even though this package manager doesn't support neovim. This package manger is being used as a utility to install and update packages. This config utilizes (neo)vim's builtin plugin runtime management to load plugin(mostly lazily).

- [Coc](https://github.com/neoclide/coc.nvim) - Intellisense engine for vim8 & neovim, full language server protocol support as VSCode

- [Vim Buffet](https://github.com/bagrat/vim-buffet) and [Spaceline](https://github.com/hardcoreplayers/spaceline.vim) - Provide an IDE-like Vim tabline & vim statusline like spacemacs

  - Provides beautiful UI

- [Vim Clap](https://github.com/liuchengxu/vim-clap) - Modern generic interactive finder and dispatcher for Vim and NeoVim

  - Extraordinarily fast interactive finder and dispatcher

- [Rafi's Vim Config](https://github.com/rafi/vim-config) - For help with some of the configs and ideas for a good readme
