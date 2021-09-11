"
" Vim-Go configuration
"

" Disable reporting `go fmt` errors. Let ALE handle it instead
let g:go_fmt_fail_silently = 1

" Use the `popup` window for documentation presentation
let g:go_doc_popup_window = 1

" Enable showing type information automatically
let g:go_auto_type_info = 1

" Enable highlighting operators
let g:go_highlight_operators = 1

" Enable highlighting function names
let g:go_highlight_functions = 1

" Enable highlighting method names
let g:go_highlight_methods = 1

" Enable highlighting struct names
let g:go_highlight_structs = 1

" Enable highlighting build constraints
let g:go_highlight_build_constraints = 1

" Don't overwrite default mappings just for some def calls...
let g:go_def_mapping_enabled = 0
