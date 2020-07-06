function! RunMyCode()
    if getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash"
        if executable('bash')
                call Run("bash %")
            else
                echom 'Bash is not installed!'
            endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash"
        if executable('dash')
            call Run("dash %")
        else
            echom 'Dash is not installed!'
        endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh"
        if executable('tcsh')
            call Run("tcsh %")
        else
            echom 'Tcsh is not installed!'
        endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh"
        if executable('csh')
            call Run("csh %")
        else
            echom 'Csh is not installed!'
        endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh"
        if executable('ksh')
            call Run("ksh %")
        else
            echom 'Ksh is not installed!'
        endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env zsh" || getline(1)[0:13] ==# "#!/usr/bin/zsh"
        if executable('zsh')
            call Run("zsh %")
        else
            echom 'Zsh is not installed!'
        endif
    elseif getline(1)[0:13] ==# "#!/usr/bin/env" || getline(1)[0:10] ==# "#!/usr/bin/"
        echom 'I dunno how to handle this shebang'
    else
        echom 'Please set a shebang'
    endif
endfunction
