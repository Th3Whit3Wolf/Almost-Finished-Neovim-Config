function! InCargoProject(...)
	if filereadable("Cargo.toml")
		return 1
	elseif filereadable("../Cargo.toml")
		return 1
	elseif filereadable("../../Cargo.toml")
		return 1
	elseif filereadable("../../Cargo.toml")
		return 1
	else
		return 0
endfunction

function! InRailsApp(...)
	return filereadable("app/controllers/application_controller.rb")
endfunction

function! AddtoKey(key, action)
	exec "let g:which_key_map." . join(split(a:key, '\zs'), '.') . " = '" . a:action . "'"
endfunction

let c_flags = "-D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS -fasynchronous-unwind-tables -fexceptions -fpie -Wl,-pie -fpic -shared -fplugin=annobin -fstack-clash-protection -fstack-protector-strong -g -grecord-gcc-switches -mcet -fcf-protection -pipe -Wall -Werror=format-security -Werror=implicit-function-declaration -Wl,-z,defs -Wl,-z,now -Wl,-z,relro"

function! Run(executor)
	exec "AsyncRun -mode=term -pos=bottom -rows=30 " . a:executor
endfunction

function CompileMyCode()
    if &modified
		write
	end
    if &filetype == 'c'
		if executable('gcc')
			call Run("gcc % -o %< " + c_flags)
		endif
	elseif &filetype == 'cpp'
		if executable('g++')
			call Run("g++ -std=c++17 % -o %< " + c_flags)
		endif
	elseif &filetype == 'go'
		if executable('go')
			call Run("go build %")
		else
			echo 'Go is not installed!'
		endif
	elseif &filetype == 'haskell'
		if executable('ghc')
			call Run("ghc % -o %<")
		else
			echo 'Haskell is not installed!'
		endif
	elseif &filetype == 'java'
		if executable('javac')
			call Run("javac %")
		else
			echo 'Java is not installed!'
		endif
	elseif &filetype == 'rust'
		if InCargoProject()
			if executable('cargo') 
				call Run("cargo build --release")
			else
				echo 'Cargo is not installed or this is not a cargo project'
			endif
		else
			if executable('rustc')
				call Run("rustc % -o %<")
			else
				echo 'Rustc is not installed or this is not a cargo project'
			endif
		endif
	else
		echo "Dunno how to run such a file..."
	endif
endfunction

function! RunMyCode()
    if &modified
		write
	end
    if &filetype == 'c'
		if executable('gcc')
			call Run("gcc % -o %<  " + c_flags +"; ./%<")
		endif
	elseif &filetype == 'cpp'
		if executable('g++')
			call Run("g++ -std=c++17 % -o %< " + c_flags +"; ./%<")
		endif
	elseif &filetype == 'rust'
		if InCargoProject()
			if executable('cargo') 
				call Run("cargo run")		
			else
				echo 'Cargo is not installed!'
			endif
		else
			if executable('rustc')
				call Run("rustc % -o %<; ./%<")			
			else
				echo 'Rustc is not installed!'
			endif
		endif
	elseif &filetype == 'html'
		let g:bracey_refresh_on_save = 1
		Bracey
	elseif &filetype == 'markdown'
		ComposerOpen
		ComposerUpdate
	elseif &filetype == 'java'
		if executable('javac')
			call Run("javac %")			
		else
			echo 'Java is not installed!'
		endif
	elseif &filetype == 'sh'
		if getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash"
			if executable('bash')
				call Run("bash %")				
			else
				echo 'Bash is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash"
			if executable('dash')
				call Run("dash %")				
			else
				echo 'Dash is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env fish" || getline(1)[0:14] ==# "#!/usr/bin/fish"
			if executable('fish')
				call Run("fish %")				
			else
				echo 'Fish is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh"
			if executable('tcsh')
				call Run("tcsh %")				
			else
				echo 'Tcsh is not installed!'
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh"
			if executable('csh')
				call Run("csh %")				
			else
				echo 'Csh is not installed!'
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh"
			if executable('ksh')
				call Run("ksh %")				
			else
				echo 'Ksh is not installed!'
			endif
		elseif getline(1)[0:17] ==# "#!/usr/bin/env zsh" || getline(1)[0:13] ==# "#!/usr/bin/zsh"
			if executable('zsh')
				call Run("zsh %")				
			else
				echo 'Zsh is not installed!'
			endif
		endif
	elseif &filetype == 'python'
		if getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3"
			if executable('python3')
				call Run("python3 %")				
			else
				echo 'Python3 is not installed!'
			endif
		elseif getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2"
			if executable('python2')
				call Run("python2 %")				
			else
				echo 'Python2 is not installed!'
			endif
		elseif getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python"
			if executable('python')
				call Run("python %")				
			else
				echo 'Python executable can not be found!'
			endif
		elseif getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3"
			if executable('pypy3')
				call Run("pypy3 %")				
			else
				echo 'Pypy3 is not installed!'
			endif
		elseif getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy"
			if executable('pypy')
				call Run("pypy %")				
			else
				echo 'Pypy is not installed!'
			endif
		elseif getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython"
			if executable('jython')
				call Run("jython %")				
			else
				echo 'Jython is not installed!'
			endif
		endif
	elseif &filetype == 'go'
		if executable('go')
			call Run("go run %")			
		else
			echo 'Go is not installed!'
		endif
	elseif &filetype == 'haskell'
		if executable('ghc')
			call Run("ghc % -o %<")			
		else
			echo 'Haskell is not installed!'
		endif
	elseif &filetype == 'javascript'
		if executable('node')
			call Run("node %")			
		else
			echo 'Node is not installed!'
		endif
	elseif &filetype == 'ruby'
		if InRailsApp()
			if executable('rails')
				call Run("rails runner %")
			else
				echo 'Rails is not installed!'
			endif
		else
			if executable('ruby')
				call Run("ruby %")
			else
				echo 'Ruby is not installed!'
			endif
		endif
	else
		echo "Dunno how to run such a file..."
	endif
endfunction

function! RunRustTest()
	if &modified
		write
	end
	if InCargoProject()
        if executable('cargo')
            AsyncRun -mode=term -pos=bottom -rows=30 cargo test --all -- --test-threads=1
        else
            echo 'Rust is not installed or this is not a cargo project'
        endif
    else
        echo "Testing is only support for Cargo projects"
    endif
endfunction