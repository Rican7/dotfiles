"
" fzf configuration
"

" Check if we don't have the fzf executable
if (executable('fzf') == 0)
    " Communicate what's happening
    augroup WarnNoFzf
        autocmd!
        autocmd VimEnter * echohl WarningMsg
        autocmd VimEnter * echom 'WARNING: No `fzf` command found.'
        autocmd VimEnter * echom 'Falling back to using "ctrlp" plugin.'
        autocmd VimEnter * echom 'Install fzf via `:call fzf#install()`.'
        autocmd VimEnter * echohl None
    augroup END

    " Quit this script
    finish
endif

" Disable ctrlp plugin
" (TODO: Remove this once the ctrlp plugin is removed)
let g:loaded_ctrlp = 1

" Enable history
let g:fzf_history_dir = '~/.cache/fzf/history'

" Function to prevent FZF commands from opening in functional buffers
"
" See: https://github.com/junegunn/fzf/issues/453
" TODO: Remove once this workaround is no longer necessary.
function! FZFOpen(cmd)
    " Define the functional buffer types that we want to not clobber
    let functional_buf_types = ['quickfix', 'help', 'nofile', 'terminal']

    " If more than 1 window, and buffer type is not one of the functional types
    if winnr('$') > 1 && (index(functional_buf_types, &bt) >= 0)
        " Find all 'normal' (not functional) buffer windows
        let norm_wins = filter(range(1, winnr('$')),
                    \ 'index(functional_buf_types, getbufvar(winbufnr(v:val), "&bt")) == -1')

        " Grab the first one that we can use
        let norm_win = !empty(norm_wins) ? norm_wins[0] : 0

        " Move to that window
        exe norm_win . 'winc w'
    endif

    " Execute the passed command
    exe a:cmd
endfunction

" Map CTRL+P to FZF
" nmap <C-P> :FZF<CR>
nmap <C-P> :call FZFOpen(':FZF')<CR>
