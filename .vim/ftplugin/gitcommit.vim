" Git Commit filetype settings
" Language:     GitCommit

" Short-circuit if already loaded
if exists("b:did_ftplugin")
	finish
endif

" Make sure to not load twice
let b:did_ftplugin = 1

" Turn on spell checking
setlocal spell
