"
" fzf configuration
"

" Check if we don't have the fzf executable
if (executable('fzf') == 0)
    " Communicate what's happening
    echohl WarningMsg
    echom 'WARNING: No `fzf` command found.'
    echom 'Falling back to using "ctrlp" plugin.'
    echom 'Install fzf via `:call fzf#install()`.'
    echohl None

    " Quit this script
    finish
endif

" Disable ctrlp plugin
" (TODO: Remove this once the ctrlp plugin is removed)
let g:loaded_ctrlp = 1

" Map CTRL+P to FZF
nmap <C-P> :FZF<CR>
