if exists('g:rufo_loaded')
  finish
endif

let g:rufo_loaded = 1

if !exists("g:rufo_auto_formatting")
  let g:rufo_auto_formatting = 0
end

autocmd BufWritePost *.rb silent! call rufo#Format()

command! Rufo call rufo#Format()
command! RufoOn let g:rufo_auto_formatting = 1
command! RufoOff let g:rufo_auto_formatting = 0
command! RufoToggle let g:rufo_auto_formatting = !g:rufo_auto_formatting
