" Fasto setup
au BufNewFile,BufRead *.fo setlocal ft=fasto
" Pow setup
au BufNewFile,BufRead *.pow setlocal ft=pow
au BufNewFile,BufRead */playbooks/*.{yml,yaml} ft=yaml.ansible
au BufNewFile,BufRead */inventory/* ft=ansible_hosts
au BufNewFile,BufRead */templates/*.{yaml,tpl} ft=yaml.gotexttmpl
au BufNewFile,BufRead */.kube/config ft=yaml

" C setup, Vim thinks .h is C++
au BufNewFile,BufRead *.h setlocal ft=c

" Coffeescript
au BufNewFile,BufRead *.coffee set ft=coffee
au BufNewFile,BufRead *Cakefile set ft=coffee
au BufNewFile,BufRead *.coffeekup,*.ck set ft=coffee
au BufNewFile,BufRead *._coffee set ft=coffee
au BufNewFile,BufRead *.litcoffee set ft=litcoffee
au BufNewFile,BufRead *.coffee.md set ft=litcoffee

" CQL
au  BufNewFile,BufRead *.cql set ft=cql

" Cryptop
au BufNewFile,BufRead *.cry set ft=cryptol
au BufNewFile,BufRead *.cyl set ft=cryptol
au BufNewFile,BufRead *.l" cry set ft=cryptol
au BufNewFile,BufRead *.lcyl set ft=cryptol

" Crystal
au BufNewFile,BufRead *.cr set ft=crystal
au BufNewFile,BufRead Projectfile set ft=crystal
au BufNewFile,BufRead *.ecr set ft=ecrystal

" csv
au BufNewFile,BufRead *.csv,*.dat,*.tsv,*.tab set ft=csv

" cucumber
au BufNewFile,BufRead *.feature,*.story set ft=cucumber

" cue
au BufNewFile,BufRead *.cue set ft=cuesheet

" dart
au BufNewFile,BufRead *.dart set ft=dart

" dhall
au BufNewFile,BufRead *.dhall set ft=dhall

" dlang
au BufNewFile,BufRead *.d set ft=d
au BufNewFile,BufRead *.lst set ft=dcov
au BufNewFile,BufRead *.dd set ft=dd
au BufNewFile,BufRead *.ddoc set ft=ddoc
au BufNewFile,BufRead *.sdl set ft=dsdl

" dockerfile
au BufNewFile,BufRead [Dd]ockerfile set ft=Dockerfile
au BufNewFile,BufRead Dockerfile* set ft=Dockerfile
au BufNewFile,BufRead [Dd]ockerfile.vim set ft=vim
au BufNewFile,BufRead *.dock set ft=Dockerfile
au BufNewFile,BufRead *.[Dd]ockerfile set ft=Dockerfile
au BufNewFile,BufRead docker-compose*.{yaml,yml}* set ft=yaml.docker-compose

" elixir
au BufNewFile,BufRead *.ex,*.exs set ft=elixir
au BufNewFile,BufRead *.eex,*.leex set ft=eelixir
au BufNewFile,BufRead mix.lock set ft=elixir

" elm
au BufNewFile,BufRead *.elm set ft=elm

" emberscript
au BufNewFile,BufRead *.em set ft=ember-script

" emblem
au BufNewFile,BufRead *.emblem set ft=emblem

" erlang
au BufNewFile,BufRead *.erl,*.hrl,rebar.config,*.app,*.app.src,*.yaws,*.xrl,*.escript set ft=erlang

" ferm
au BufNewFile,BufRead ferm.conf set ft=ferm 
au BufNewFile,BufRead *.ferm set ft=ferm

" fish
au BufNewFile,BufRead *.fish set ft=fish
au BufNewFile,BufRead ~/.config/fish/fish_{read_,}history set ft=yaml
au BufNewFile,BufRead * if getline(1)[0:18] ==# "#!/usr/bin/env fish" || getline(1)[0:14] ==# "#!/usr/bin/fish" | set ft=fish | endif

" flatbuffers
au BufNewFile,BufRead *.fbs set ft=fbs

" fsharp
au BufNewFile,BufRead *.fs,*.fsi,*.fsx set ft=fsharp

" gdscript
au BufNewFile,BufRead *.gd set ft=gdscript3
au BufNewFile,BufRead *.shader set ft=gsl

" git
au BufNewFile,BufRead *.git/{,modules/**/,worktrees/*/}{COMMIT_EDIT,TAG_EDIT,MERGE_,}MSG set ft=gitcommit
au BufNewFile,BufRead *.git/config,.gitconfig,gitconfig,.gitmodules set ft=gitconfig
au BufNewFile,BufRead */.config/git/config set ft=gitconfig
au BufNewFile,BufRead *.git/modules/**/config set ft=gitconfig
au BufNewFile,BufRead git-rebase-todo set ft=gitrebase
au BufNewFile,BufRead .gitsendemail.* set ft=gitsendemail
au BufNewFile,BufRead *.git/**
    \ if getline(1) =~ '^\x\{40\}\>\|^ref: ' |
    \   set ft=git |
    \ endif

" This logic really belongs in scripts.vim
au BufNewFile,BufRead,StdinReadPost *
    \ if getline(1) =~ '^\(commit\|tree\|object\) \x\{40\}\>\|^tag \S\+$' |
    \   set ft=git |
    \ endif
au BufNewFile,BufRead *
    \ if getline(1) =~ '^From \x\{40\} Mon Sep 17 00:00:00 2001$' |
    \   set filetype=gitsendemail |
    \ endif

" glsl
au BufNewFile,BufRead *.vert,*.tesc,*.tese,*.glsl,*.geom,*.frag,*.comp set ft=glsl

" gmpl
au BufNewFile,BufRead *.mod set ft=gmpl

" go
au BufNewFile,BufRead *.go set ft=go
au BufNewFile,BufRead *.s set ft=asm
au BufNewFile,BufRead *.tmpl set ft=gohtmltmpl
au BufNewFile,BufRead go.mod set ft=gomod

" graphql
au BufNewFile,BufRead *.graphql,*.graphqls,*.gql set ft=graphql

" gradle
au BufNewFile,BufRead *.gradle set ft=groovy

" haml
au BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc set ft=haml

" handlebars
au  BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set ft=html.mustache syn=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim indent/handlebars.vim
au  BufNewFile,BufRead *.handlebars,*.hdbs,*.hbs,*.hb set ft=html.handlebars syn=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim

" haproxy
au BufNewFile,BufRead haproxy*.c* set ft=haproxy

" haskell
au BufNewFile,BufRead *.hsc set ft=haskell
au BufNewFile,BufRead *.bpk set ft=haskell
au BufNewFile,BufRead *.hsig set ft=haskell

" haxe
au BufNewFile,BufRead *.hx set ft=haxe

" hcl
au BufNewFile,BufRead *.hcl set ft=hcl
au BufNewFile,BufRead *.nomad set ft=hcl
au BufNewFile,BufRead *.tf set ft=hcl
au BufNewFile,BufRead Appfile set ft=hcl

" helm
au BufNewFile,BufRead */templates/*.yaml,*/templates/*.tpl set ft=helm

" hive
au BufNewFile,BufRead *.hql set ft=hive
au BufNewFile,BufRead *.ql set ft=hive
au BufNewFile,BufRead *.q set ft=hive

" i3
au BufNewFile,BufRead .i3.config,i3.config,*.i3config,*.i3.config set ft=i3config

" icalendar
au BufNewFile,BufRead *.ics set ft=icalendar

" idris
au BufNewFile,BufRead *.idr set ft=idris
au BufNewFile,BufRead idris-response set ft=idris
au BufNewFile,BufRead *.lidr set ft=lidris

" ion
au BufNewFile,BufRead ~/.config/ion/initrc set ft=ion
au BufNewFile,BufRead *.ion set ft=ion
au BufNewFile,BufRead * if getline(1)[0:17] ==# "#!/usr/bin/env ion" || getline(1)[0:13] ==# "#!/usr/bin/ion" | set ft=fish | endif

" Janus setup
au BufNewFile,BufRead *.ja setlocal ft=janus

" javascript
au BufNewFile,BufRead *.flow set ft=flow
au BufNewFile,BufRead yarn.lock ft=yaml
au BufNewFile,BufRead .flowconfig ft=ini
au BufNewFile,BufRead *.js.map ft=json
au BufNewFile,BufRead .jsbeautifyrc ft=json
au BufNewFile,BufRead .eslintrc ft=json
au BufNewFile,BufRead .jscsrc ft=json
au BufNewFile,BufRead .babelrc ft=json
au BufNewFile,BufRead .watchmanconfig ft=json
au BufNewFile,BufRead .buckconfig ft=toml
au BufNewFile,BufRead .flowconfig ft=ini
au BufNewFile,BufRead *.{js,mjs,cjs,jsm,es,es6},Jakefile set ft=javascript
au BufNewFile,BufRead .tern-{project,port} ft=json
au BufNewFile,BufRead *.postman_collection ft=json

" jenkins
au BufNewFile,BufRead Jenkinsfile set ft=Jenkinsfile
au BufNewFile,BufRead Jenkinsfile* set ft=Jenkinsfile
au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
au BufNewFile,BufRead *.jenkinsfile set ft=Jenkinsfile
au BufNewFile,BufRead *.Jenkinsfile set ft=Jenkinsfile

" jinja
au BufNewFile,BufRead *.jinja2,*.j2,*.jinja,*.nunjucks,*.nunjs,*.njk set ft=jinja
au BufNewFile,BufRead *.html.jinja2,*.html.j2,*.html.jinja,*.htm.jinja2,*.htm.j2,*.htm.jinja set ft=jinja.html

" json5
au BufNewFile,BufRead *.json5 set ft=json5

" json
au BufNewFile,BufRead *.json set ft=json
au BufNewFile,BufRead *.jsonl set ft=json
au BufNewFile,BufRead *.jsonp set ft=json
au BufNewFile,BufRead *.geojson set ft=json
au BufNewFile,BufRead *.template set ft=json

" jst
au BufNewFile,BufRead *.ejs set ft=jst
au BufNewFile,BufRead *.jst set ft=jst
au BufNewFile,BufRead *.djs set ft=jst
au BufNewFile,BufRead *.hamljs set ft=jst
au BufNewFile,BufRead *.ect set ft=jst

" jsx
au BufNewFile,BufRead *.jsx set ft=javascriptreact

" julia
au BufNewFile,BufRead *.jl set ft=julia

" justfile
au BufNewFile,BufRead Justfile,justfile ft=make

" kotlin
au BufNewFile,BufRead *.kt set ft=kotlin
au BufNewFile,BufRead *.kts set ft=kotlin

" ledger
au BufNewFile,BufRead *.ldg,*.ledger,*.journal set ft=ledger

" less
au BufNewFile,BufRead *.less set ft=less

" lilypond
au BufNewFile,BufRead *.ly,*.ily set ft=lilypond

" livescript
au BufNewFile,BufRead *.ls set ft=ls
au BufNewFile,BufRead *Slakefile set ft=ls

" llvm
au BufNewFile,BufRead *.ll set ft=llvm

" llvm
au BufNewFile,BufRead lit.*cfg set ft=python
au BufNewFile,BufRead *.td set ft=tablegen

" log
au BufNewFile,BufRead *.log set ft=log
au BufNewFile,BufRead *_log set ft=log

" mako
au BufNewFile *.*.mako execute "do BufNewFile filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
au BufReadPre *.*.mako execute "do BufRead filetypedetect " . expand("<afile>:r") | let b:mako_outer_lang = &filetype
au BufNewFile,BufRead *.mako set ft=mako

" markdown
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} set ft=markdown
au BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set ft=markdown

" mathematica
au BufNewFile,BufRead *.wl set ft=mma
au BufNewFile,BufRead *.wls set ft=mma
au BufNewFile,BufRead *.nb set ft=mma
au BufNewFile,BufRead *.m set ft=mma

" mdx
au BufNewFile,BufRead *.mdx set ft=markdown.mdx

" meson
au BufNewFile,BufRead meson.build set ft=meson
au BufNewFile,BufRead meson_options.txt set ft=meson
au BufNewFile,BufRead *.wrap set ft=dosini

" moonscript
au BufNewFile,BufRead *.moon set ft=moon

" nginx
au BufNewFile,BufRead *.nginx set ft=nginx
au BufNewFile,BufRead nginx*.conf set ft=nginx
au BufNewFile,BufRead *nginx.conf set ft=nginx
au BufNewFile,BufRead */etc/nginx/* set ft=nginx
au BufNewFile,BufRead */usr/local/nginx/conf/* set ft=nginx
au BufNewFile,BufRead */nginx/*.conf set ft=nginx

" nim
au BufNewFile,BufRead *.nim,*.nims,*.nimble set ft=nim

" nix
au BufNewFile,BufRead *.nix set ft=nix

" ocaml
au BufNewFile,BufRead jbuild,dune,dune-project,dune-workspace set ft=dune
au BufNewFile,BufRead _oasis set ft=oasis
au BufNewFile,BufRead *.ml,*.mli,*.mll,*.mly,.ocamlinit,*.mlt,*.mlp,*.mlip,*.mli.cppo,*.ml.cppo set ft=ocaml
au BufNewFile,BufRead _tags set ft=ocamlbuild_tags
au BufNewFile,BufRead OMakefile,OMakeroot,*.om,OMakeroot.in set ft=omake
au BufNewFile,BufRead opam,*.opam,*.opam.template set ft=opam
au BufNewFile,BufRead *.sexp set ft=sexplib

" opencl
au BufNewFile,BufRead *.cl set ft=opencl

" perl
au BufNew,BufNewFile,BufRead *.nqp set ft=perl6

" pgsql
au BufNewFile,BufRead *.pgsql let b:sql_type_override='pgsql' | set ft=sql

" plantuml
au BufNewFile,BufRead *.pu,*.uml,*.plantuml,*.puml set ft=plantuml

" pony
au BufNewFile,BufRead *.pony set ft=pony

" powershell
au BufNewFile,BufRead *.ps1 set ft=ps1
au BufNewFile,BufRead *.psd1 set ft=ps1
au BufNewFile,BufRead *.psm1 set ft=ps1
au BufNewFile,BufRead *.pssc set ft=ps1
au BufNewFile,BufRead *.ps1xml set ft=ps1xml
au BufNewFile,BufRead *.cdxml set ft=xml
au BufNewFile,BufRead *.psc1 set ft=xml

" protobuf
au BufNewFile,BufRead *.proto set ft=proto

" pug
au BufNewFile,BufRead *.pug set ft=pug
au BufNewFile,BufRead *.jade set ft=pug

" puppet
au BufNewFile,BufRead *.pp set ft=puppet
au BufNewFile,BufRead *.epp set ft=embeddedpuppet
au BufNewFile,BufRead Puppetfile set ft=ruby

" purescript
au BufNewFile,BufRead *.purs set ft=purescript

" qmake
au BufNewFile,BufRead *.pri set ft=qmake

" qmake
au BufNewFile,BufRead *.pro set ft=qmake

" qml
au BufNewFile,BufRead *.qml set ft=qml

" racket
au BufNewFile,BufRead *.rkt,*.rktl set ft=racket

" raku
au BufNewFile,BufRead *.pm6,*.p6,*.t6,*.pod6,*.raku,*.rakumod,*.rakudoc,*.rakutest set ft=raku

" raml
au BufNewFile,BufRead *.raml set ft=raml

" razor
au BufNewFile,BufRead *.cshtml set ft=razor

" reason
au BufNewFile,BufRead *.re set ft=reason
au BufNewFile,BufRead *.rei set ft=reason
au BufNewFile,BufRead .merlin set ft=merlin

" ruby
au BufNewFile,BufRead *.erb,*.rhtml set ft=eruby
au BufNewFile,BufRead .irbrc,irbrc set ft=ruby
au BufNewFile,BufRead *.rb,*.rbw,*.gemspec set ft=ruby
au BufNewFile,BufRead *.ru set ft=ruby
au BufNewFile,BufRead Gemfile set ft=ruby
au BufNewFile,BufRead *.builder,*.rxml,*.rjs,*.ruby set ft=ruby
au BufNewFile,BufRead [rR]akefile,*.rake set ft=ruby
au BufNewFile,BufRead [rR]antfile,*.rant set ft=ruby
au BufNewFile,BufRead Appraisals set ft=ruby
au BufNewFile,BufRead .autotest set ft=ruby
au BufNewFile,BufRead *.axlsx set ft=ruby
au BufNewFile,BufRead [Bb]uildfile set ft=ruby
au BufNewFile,BufRead Capfile,*.cap set ft=ruby
au BufNewFile,BufRead Cheffile set ft=ruby
au BufNewFile,BufRead Berksfile set ft=ruby
au BufNewFile,BufRead Podfile,*.podspec set ft=ruby
au BufNewFile,BufRead Guardfile,.Guardfile set ft=ruby
au BufNewFile,BufRead *.jbuilder set ft=ruby
au BufNewFile,BufRead KitchenSink set ft=ruby
au BufNewFile,BufRead *.opal set ft=ruby
au BufNewFile,BufRead .pryrc set ft=ruby
au BufNewFile,BufRead Puppetfile set ft=ruby
au BufNewFile,BufRead *.rabl set ft=ruby
au BufNewFile,BufRead [rR]outefile set ft=ruby
au BufNewFile,BufRead .simplecov set ft=ruby
au BufNewFile,BufRead *.rbi set ft=ruby
au BufNewFile,BufRead [tT]horfile,*.thor set ft=ruby
au BufNewFile,BufRead [vV]agrantfile set ft=ruby
au BufNewFile,BufRead Brewfile set ft=ruby

" Declared after ruby so that the more general *.rb
" doesn't override
" rspec
au BufNewFile,BufRead *_spec.rb set ft=rspec

" rust
au BufNewFile,BufRead *.rs set ft=rust

" scala
au BufNewFile,BufRead *.scala,*.sc set ft=scala
au BufNewFile,BufRead *.sbt set ft=sbt.scala
au BufNewFile,BufRead *.sbt set ft=sbt.scala

" scss
au BufNewFile,BufRead *.scss set ft=scss

" slim
au BufNewFile,BufRead *.slim set ft=slim

" slime
au BufNewFile,BufRead *.slime set ft=slime

" smt2
au BufNewFile,BufRead *.smt,*.smt2 set ft=smt2

" solidity
au BufNewFile,BufRead *.sol set ft=solidity

" stylus
au BufNewFile,BufRead *.styl set ft=stylus
au BufNewFile,BufRead *.stylus set ft=stylus

" svelte
au BufNewFile,BufRead *.svelte set ft=svelte

" swift
au BufNewFile,BufRead *.swift set ft=swift

" sxhkd
au BufNewFile,BufRead sxhkdrc,*.sxhkdrc set ft=sxhkdrc

" systemd
au BufNewFile,BufRead *.automount set ft=systemd
au BufNewFile,BufRead *.mount set ft=systemd
au BufNewFile,BufRead *.path set ft=systemd
au BufNewFile,BufRead *.service set ft=systemd
au BufNewFile,BufRead *.socket set ft=systemd
au BufNewFile,BufRead *.swap set ft=systemd
au BufNewFile,BufRead *.target set ft=systemd
au BufNewFile,BufRead *.timer set ft=systemd

" terraform
au BufNewFile,BufRead *.tf set ft=terraform
au BufNewFile,BufRead *.tfvars set ft=terraform
au BufNewFile,BufRead *.tfstate set ft=json
au BufNewFile,BufRead *.tfstate.backup set ft=json

" textile
au BufNewFile,BufRead *.textile set ft=textile

" thrift
au BufNewFile,BufRead *.thrift set ft=thrift

" tmux
au BufNewFile,BufRead {.,}tmux.conf set ft=tmux

" toml
au BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,*/.cargo/credentials,Pipfile set ft=toml

" tptp
au BufNewFile,BufRead *.p set ft=tptp
au BufNewFile,BufRead *.tptp set ft=tptp
au BufNewFile,BufRead *.ax set ft=tptp

" twig
au BufNewFile,BufRead *.twig set ft=html.twig
au BufNewFile,BufRead *.html.twig set ft=html.twig
au BufNewFile,BufRead *.xml.twig set ft=xml.twig

" typescript
au BufNewFile,BufRead *.ts set ft=typescript
au BufNewFile,BufRead *.tsx set ft=typescriptreact

" v
au BufNewFile,BufRead *.v set ft=vlang

" vala
au BufNewFile,BufRead *.vala,*.vapi,*.valadoc set ft=vala

" vbnet
au BufNewFile,BufRead *.vb set ft=vbnet

" vcl
au BufNewFile,BufRead *.vcl set ft=vcl

" vifm
au BufNewFile,BufRead vifmrc set ft=vifm
au BufNewFile,BufRead *vifm/colors/* set ft=vifm
au BufNewFile,BufRead *.vifm set ft=vifm
au BufNewFile,BufRead vifm.rename* set ft=vifm-rename

" vm
au BufNewFile,BufRead *.vm set ft=velocity

" vue
au BufNewFile,BufRead *.vue,*.wpy set ft=vue

" xdc
au BufNewFile,BufRead *.xdc set ft=xdc

" zephir
au BufNewFile,BufRead *.zep set ft=zephir

" zig
au BufNewFile,BufRead *.zig set ft=zig
au BufNewFile,BufRead *.zir set ft=zir