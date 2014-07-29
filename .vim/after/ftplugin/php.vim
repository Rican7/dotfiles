" Vim AFTER file
" Language:     PHP
"
" This script is designed to be run after Vim processes other runtime files,
" so that it can fix any strange conflicts or run custom post-load tasks

" Reset our PHP formatting options, in case something else changed it
let b:optionsset = 0
call ResetPhpOptions()
