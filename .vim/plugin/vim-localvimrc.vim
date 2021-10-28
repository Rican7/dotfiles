"
" vim-localvimrc configuration
"

" Behavior options
let g:localvimrc_name = [ '.lvimrc' ]
let g:localvimrc_event = [ 'VimEnter', 'DirChanged', 'SessionLoadPost' ]
let g:localvimrc_ask = 1 " Ask to load a config file
let g:localvimrc_persistent = 2 " Don't ask to load the same known config file

" Perform some operations based on events
augroup LocalVimRC
    autocmd!

    function! PrintLoadedRC()
        let l:message = 'Loaded local vimrc'
        if g:localvimrc_script_unresolved == g:localvimrc_script
            echom printf(
                \'%s: "%s"',
                \l:message,
                \g:localvimrc_script
            \)
        elseif g:localvimrc_script_unresolved != g:localvimrc_script
            echom printf(
                \'%s: "%s" ("%s")',
                \l:message,
                \g:localvimrc_script_unresolved,
                \g:localvimrc_script
            \)
        endif
    endfunction

    autocmd User LocalVimRCPost call PrintLoadedRC()
augroup END

" TODO: Remove once VimEnter events are solved
"
" See https://github.com/embear/vim-localvimrc/issues/82
let g:localvimrc_event += [ 'BufWinEnter' ]
augroup LocalVimRCEnterFix
    autocmd!
    autocmd User LocalVimRCPost :LocalVimRCDisable
augroup END
