" Go filetype settings
" Language:     Go

execute "setlocal colorcolumn=81," . join(range(121, &columns+1), ',')

nnoremap <buffer> <silent> gd :GoDef<cr>
nnoremap <buffer> <silent> <C-]> :GoDef<cr>
nnoremap <buffer> <silent> <C-w><C-]> :<C-u>call go#def#Jump("vsplit", 0)<CR>
nnoremap <buffer> <silent> <C-w><C-\> :<C-u>call go#def#Jump("split", 0)<CR>
