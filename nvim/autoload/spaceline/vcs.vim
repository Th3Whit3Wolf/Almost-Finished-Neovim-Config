" =============================================================================
" Filename: spaceline.vim
" Author: taigacute
" URL: https://github.com/taigacute/spaceline.vim
" License: MIT License
" =============================================================================
"
function! spaceline#vcs#git_branch()
  if g:spaceline_git == 'coc'
    let l:gitbranch = get(g:, 'coc_git_status', '')
  elseif g:spaceline_git == 'gina'
    let l:git_branch_icon = exists('g:spaceline_git_branch_icon') ? g:spaceline_git_branch_icon : ''
    let l:gitbranch = gina#component#repo#branch()
    if exists('l:git_branch_icon')
      return l:git_branch_icon . " " . l:gitbranch
    endif
    return l:gitbranch
  else
    let l:git_branch_icon = exists('g:spaceline_git_branch_icon') ? g:spaceline_git_branch_icon : ''
    if &modifiable
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let l:gitbranch="(".substitute(l:gitrevparse, '', '', 'g').") "
      endif
    endif
  endif
  if empty(l:gitbranch)
    return ""
  endif
  if exists('l:git_branch_icon')
    return l:git_branch_icon . l:gitbranch
  endif
  return l:gitbranch
endfunction

function! s:add_diff_icon(type) abort
  let difficon = get(['','',''],a:type,'')
  if g:spaceline_git == 'coc'
    let diffdata = split(get(b:, 'coc_git_status', ''),' ')
  else
    let added    = len(systemlist('git diff -U0 | grep + | grep -v +++ | grep -v @@'))
    let removed  = len(systemlist('git diff -U0 | grep - | grep -v --- | grep -v @@'))
    let changed  = added > removed ? removed : added
    let diffdata = [added, removed, changed]
  endif
  let diff_flags = ''
  if a:type == 0
    let diff_flags = '+'
  elseif a:type == 1
    let diff_flags = '-'
  elseif a:type == 2
    let diff_flags = '\~'
  endif
  for item in diffdata
    if matchend(item,diff_flags) > 0
        if g:symbol == 1
          return item
        else
          return substitute(item, diff_flags, difficon, '').' '
        endif
    endif
  endfor
endfunction

function! spaceline#vcs#diff_add() abort
  return s:add_diff_icon(0)
endfunction

function! spaceline#vcs#diff_remove() abort
  return s:add_diff_icon(1)
endfunction

function! spaceline#vcs#diff_modified() abort
  return s:add_diff_icon(2)
endfunction
