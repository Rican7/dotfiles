"
" DetectIndent configuration
"

" Attempt to automatically detect the indentation of the file
autocmd BufReadPost * DetectIndent

" Set some indentation detection options
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
