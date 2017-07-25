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
  let l:current_view = winsaveview()

  let [l:start_line, l:end_line] = [1, '$']
  let [l:formatting_failed, l:out] = s:format(l:start_line, l:end_line)
  if l:formatting_failed
    call s:show_error(l:out)
  else
    call s:replace(l:start_line, l:end_line, l:out)
    silent exec l:end_line . 'delete _'
  endif

  call winrestview(l:current_view)
endf

function! s:format_selection(start_line, end_line) abort
  let l:last_line_is_empty_line_between_code_blocks = getline(a:end_line) == '' && getline(a:end_line + 1) != ''

  let [l:formatting_failed, l:out] = s:format(a:start_line, a:end_line)
  if l:formatting_failed
    call s:show_error(l:out)
  else
    call s:replace(a:start_line, a:end_line, l:out)

    " restore indentation
    silent exec 'normal! ' . a:start_line . 'GV' . a:end_line . 'G='

    " keep empty line between code blocks
    if l:last_line_is_empty_line_between_code_blocks
      call append(a:end_line - 1, '')
    endif
  endif
endf

function! s:format(start_line, end_line) abort
  let l:buffer_number = bufnr(s:default_buffer_name)
  if buffer_exists(l:buffer_number)
    silent exec l:buffer_number . 'bdelete'
  endif

  let l:selection = join(getline(a:start_line, a:end_line), '\n')
  let l:out = systemlist('echo ' . shellescape(l:selection) . '| rufo')
  return [s:formatting_failed(l:out), l:out]
endf

function! s:formatting_failed(message) abort
  return a:message[0] =~ 'Error'
endf

function! s:show_error(message) abort
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
    call s:replace(1, line('$'), a:message)
  else
    silent exec l:buffer_position . ' new ' . s:default_buffer_name
    call append(0, a:message)
    setlocal buftype=nofile bufhidden=hide nobuflisted noswapfile
  endif
  silent exec line('$') . 'delete _'
  setlocal nomodifiable
endf

func! s:replace(start_line, end_line, text) abort
  silent exec a:start_line . ',' . a:end_line . 'delete _'
  call append(a:start_line - 1, a:text)
endfunc
