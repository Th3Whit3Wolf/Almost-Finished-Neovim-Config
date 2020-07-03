packadd python-syntax
packadd vim-python-pep8-indent

let g:python_highlight_all = 1
let g:python_highlight_space_errors = 1
if getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3"
elseif getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2"
    Python2Syntax
elseif getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python"
    Python3Syntax
elseif getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3"
    Python3Syntax
elseif getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy"
    Python2Syntax
elseif getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython"
    Python2Syntax
endif

function! RunMyCode()
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
    else
        call Run("python %")
        echom 'Please set a python shebang'
    endif
endfunction

set expandtab tabstop=4 softtabstop=4 shiftwidth=4
