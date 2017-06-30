function! rufo#Format() abort
  let l:filename = expand('%')

  let l:curw = {}
  try
    mkview!
  catch
    let l:curw = winsaveview()
  endtry

  let l:out = system('rufo ' . l:filename)
  try | silent undojoin | catch | endtry
  silent edit!
  let &syntax = &syntax
  echohl Error | echomsg l:out | echohl None

  call winrestview(l:curw)
endf

function! rufo#AutoFormat() abort
  if g:rufo_auto_formatting
    call rufo#Format()
  endif
endf
