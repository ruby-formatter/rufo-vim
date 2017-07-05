let s:buffer_positions = {
  \ 'top': 'leftabove',
  \ 'bottom': 'rightbelow',
  \ 'left': 'vertical leftabove',
  \ 'right': 'vertical rightbelow',
  \ }

let s:default_buffer_name = '_rufo'

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

function! s:format_file() abort
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

  if s:formatting_failed(l:out)
    call s:show_error(l:out)
  endif

  call winrestview(l:curw)
endf

function! s:format_selection(start_line, end_line) abort
  let l:selection = getline(a:start_line, a:end_line)
  let l:tempfile = tempname()
  let l:last_line_is_empty_line_between_code_blocks = getline(a:end_line) == '' && getline(a:end_line + 1) != ''

  call writefile(l:selection, l:tempfile)
  let l:out = system('rufo ' . l:tempfile)

  if s:formatting_failed(l:out)
    call s:show_error(l:out)
    return
  endif

  let l:result = readfile(l:tempfile)
  silent exec a:start_line . ',' . a:end_line . ' delete'
  call append(a:start_line - 1, l:result)
  call delete(l:tempfile)

  " restore indentation
  silent exec 'normal! ' . a:start_line . 'GV' . a:end_line . 'G='

  " keep empty line between code blocks
  if l:last_line_is_empty_line_between_code_blocks
    call append(a:end_line - 1, '')
  endif
endf

function! s:formatting_failed(message) abort
  let l:message = split(a:message, '\n')
  return empty(l:message) ? 0 : l:message[0] !~ 'Format'
endf

function! s:show_error(message) abort
  let l:message = split(a:message, '\n')
  let l:buffer_position = get(s:buffer_positions, g:rufo_errors_buffer_position, s:buffer_positions.bottom)
  let l:buffer_number = bufnr(s:default_buffer_name)

  if buffer_exists(l:buffer_number)
    let window_number = bufwinnr(l:buffer_number)

    " buffer closed
    if l:window_number == -1
      " open buffer
      silent exec l:buffer_position . ' split ' . '+buffer' . l:buffer_number
    else
      " change focus to buffer
      silent exec l:window_number . 'wincmd w'
    endif

    setlocal modifiable
    silent exec '0,' . line('$') . 'delete'
    call append(0, l:message)
  else
    silent exec l:buffer_position . ' new ' . s:default_buffer_name
    call append(0, l:message)
    setlocal buftype=nofile bufhidden=hide nobuflisted noswapfile
  endif
  silent exec line('$') . 'delete'
  setlocal nomodifiable
endf
