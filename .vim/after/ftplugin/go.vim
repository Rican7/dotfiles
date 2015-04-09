" Vim AFTER file
" Language:     Go
"
" This script is designed to be run after Vim processes other runtime files,
" so that it can fix any strange conflicts or run custom post-load tasks

" Set our detect indent configuration for Go files
let b:detectindent_preferred_expandtab = 0
let b:detectindent_preferred_indent = 4
let b:detectindent_preferred_when_mixed = 1
