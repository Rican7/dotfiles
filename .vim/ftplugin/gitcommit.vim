" Git Commit filetype settings
" Language:     GitCommit

" Turn on spell checking
setlocal spell

execute "setlocal colorcolumn=51," . join(range(73, &columns+1), ',')
