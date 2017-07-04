function! rufo#Format(start_line, end_line, count) abort
  if a:count
    call s:format_selection(a:start_line, a:end_line)
  else
    call s:format_file()
  end
endf

function! rufo#AutoFormat() abort
  if g:rufo_auto_formatting
    call s:format_file()
  endif
endf

function! s:format_file()
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

function! s:format_selection(start_line, end_line)
  let l:selection = getline(a:start_line, a:end_line)
  let l:tempfile = tempname()
  let l:last_line_is_empty_line_between_code_blocks = getline(a:end_line) == '' && getline(a:end_line + 1) != ''

  call writefile(l:selection, l:tempfile)
  call system('rufo ' . l:tempfile)
  let l:result = readfile(l:tempfile)
  exec a:start_line . ',' . a:end_line . ' delete'
  call append(a:start_line - 1, l:result)
  call delete(l:tempfile)

  " restore indentation
  silent exec 'normal! ' . a:start_line . 'GV' . a:end_line . 'G='

  " keep empty line between code blocks
  if l:last_line_is_empty_line_between_code_blocks
    call append(a:end_line - 1, '')
  endif
endf
