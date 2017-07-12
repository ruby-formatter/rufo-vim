if exists('g:rufo_loaded')
  finish
endif

let g:rufo_loaded = 1

if !exists('g:rufo_format_before_saving')
  let g:rufo_format_before_saving = 0
end

if !exists('g:rufo_auto_formatting')
  let g:rufo_auto_formatting = 0
end

if !exists('g:rufo_errors_buffer_position')
  let g:rufo_errors_buffer_position = 'bottom'
endif

if get(g:, "rufo_saving", 0)
  autocmd BufWritePre *.rb silent! call rufo#format_file()
endif

function! s:init_commands()
  command! -nargs=0 -range=0 Rufo call rufo#Format(<line1>, <line2>, <count>)
  command! RufoOn let g:rufo_auto_formatting = 1
  command! RufoOff let g:rufo_auto_formatting = 0
  command! RufoToggle let g:rufo_auto_formatting = !g:rufo_auto_formatting
endf

augroup RufoFormatBeforeSave
  autocmd!
  autocmd BufWritePre *.rb silent! call rufo#FormatBeforeSave()
augroup END

augroup RufoAutoFormat
  autocmd!
  autocmd BufWritePost *.rb silent! call rufo#AutoFormat()
augroup END

augroup RufoCommands
  autocmd!
  autocmd FileType ruby call s:init_commands()
augroup END
