if exists('g:rufo_loaded')
  finish
endif

let g:rufo_loaded = 1

if !exists("g:rufo_auto_formatting")
  let g:rufo_auto_formatting = 0
end

function! s:init_commands()
  command! -nargs=0 -range=0 Rufo call rufo#Format(<line1>, <line2>, <count>)
  command! RufoOn let g:rufo_auto_formatting = 1
  command! RufoOff let g:rufo_auto_formatting = 0
  command! RufoToggle let g:rufo_auto_formatting = !g:rufo_auto_formatting
endf

augroup RufoAutoFormat
  autocmd!
  autocmd BufWritePost *.rb silent! call rufo#AutoFormat()
augroup END

augroup RufoCommands
  autocmd!
  autocmd FileType ruby call s:init_commands()
augroup END
