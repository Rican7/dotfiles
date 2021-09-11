"
" Function definitions
"

" Function for toggling paste mode on/off
function! TogglePasteMode ()
    if (&paste)
        set nopaste
        echo "paste mode off"
    else
        set paste
        echo "paste mode on"
    endif
endfunction

" Function for toggling expandtab mode on/off
function! ToggleExpandTab ()
    if (&expandtab)
        set noexpandtab
        echo "hard tabs on"
    else
        set expandtab
        echo "soft tabs on"
    endif
endfunction

" Function for toggling showing numbers between multiple types of display (relative, normal, off)
function! ToggleShowNumbers ()
    if (&number)
        set nonumber
        echo "disabling numbers"
    elseif exists("*NumberToggle")
        call NumberToggle()
        echo "toggling relative/normal numbers"
    else
        set number
        echo "enabling numbers"
    endif
endfunction

" Function for deleting (closing) all hidden (un-opened) buffers
" Source - http://stackoverflow.com/a/8459043/852382
function! RemoveHiddenBuffers ()
    let tpbl=[]

    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')

    let num_deleted=0

    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1 && empty(getbufvar(v:val, "&buftype"))')
        silent execute 'bwipeout' buf
        let num_deleted = num_deleted + 1
    endfor

    echo "Removed ". num_deleted ." buffers"
endfunction

" Function for changing theme colors to a 'true black'.
" Useful for changing dark themes to actual black.
function! TrueBlack ()
    highlight Normal ctermbg=Black ctermfg=NONE guibg=Black guifg=#f2f2f2
endfunction

