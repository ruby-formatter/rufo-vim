if exists('g:rufo_loaded')
  finish
endif

let g:rufo_loaded = 1

autocmd BufWritePost *.rb silent! call rufo#Format()
