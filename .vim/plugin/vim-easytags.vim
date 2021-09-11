"
" Vim-Easytags configuration
"

" Enable async operation
let g:easytags_async = 1

" Use project specific tags files (fall back to a global)
let g:easytags_dynamic_files = 1

" Language specific settings
let g:easytags_languages = {
\   'php': {
\     'cmd': 'phpctags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R'
\   },
\   'go': {
\     'cmd': 'gotags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f -',
\       'recurse_flag': '-R'
\   }
\}
