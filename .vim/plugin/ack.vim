"
" Ack.vim configuration
"

if (1 == executable('rg'))
    " If 'rg' (ripgrep) is installed, use it as the search program
    let g:ackprg = 'rg --no-heading --vimgrep'
elseif (1 == executable('sift'))
    " If 'sift' is installed, use it as the search program
    let g:ackprg = 'sift --filename --no-color --no-group --column'
endif
