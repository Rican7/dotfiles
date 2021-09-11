" PHP filetype settings
" Language:     PHP

execute "setlocal colorcolumn=81," . join(range(121, &columns+1), ',')

setlocal omnifunc=phpcomplete#CompletePHP

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=0
let php_folding=0

setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" Insert the current namespace according to PSR-0 spec
" (https://github.com/php-fig/fig-standards/blob/60f3bc5543f1bb98efd6c559633687e6c73d2476/accepted/PSR-0.md)
inoremap \pn <C-R>=expand("%:p:h:s?.*\/[^A-Z]\\+\\C??:gs?/?\\?")<CR>

" PHP-Doc configuration and key-mappings
" inoremap <leader>c <ESC>:call PhpDocSingle()<CR>i
nnoremap <leader>c :call PhpDocSingle()<CR>
vnoremap <leader>c :call PhpDocRange()<CR>
let g:pdv_cfg_autoEndFunction = 0 " Disable function end trailing comment
let g:pdv_cfg_autoEndClass = 0 " Disable class end trailing comment
let g:pdv_cfg_php4always = 0 " Disable PHP-4 style tags from being used in PHP-5
let g:pdv_cfg_createClassTags = 0 " Disable complex tags from being created for classes

" PHP-Vim-Namespace configuration and key-mappings
" inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

" Automaticaly order `use` statements on save
autocmd BufWritePre <buffer> call OrderUseStatements()

" PHP-Indenting-for-Vim configuration
let g:PHP_autoformatcomment = 1 " Format comments automatically
let g:PHP_vintage_case_default_indent = 1 " Use the older style of switch/case indentation

" AutoTag configuration
" let g:autotagCtagsCmd="phptags --phptags-merge --phptags-merge-priority"
" let g:autotagPostCmd="cat tags | eval $(phptags --phptags-echo-filters) > tags"


"
" Command mappings
"

command! FixTrevorSpaces :%s/\((\|\[\)\s\+\(.\{-}\)\s\+\()\|\]\)/\1\2\3/g
command! FixClassStartBrace :%s/class\(.*\)\(\s\+\){/class\1\r{/g
command! FixClassEndBrace :%s/^\(\n\+\)}\(\s\+\)\/\/ End.*/}/g
command! FixMethodStartBrace :%s/^\(\s\+\)\(public\|private\|protected\) function \(.\{-}\)\s\+{/\1\2 function \3\r\1{/g
command! FixImplicitPropertyVisibility :%s/^\(\s\+\)static \$/\1public static \$/g
command! UpgradePHPArrays :%s/array(\(\_.\{-}\))/[\1]/g


"
" Function definitions
"

" Function for ordering PHP use statements
function! OrderUseStatements ()
    " Save our undo file so that we can restore it after this function runs
    " This allows us to run this function without it being part of the history
    let tmpundofile = tempname()
    execute 'wundo! '. tmpundofile

    " Grab our cursor's current position
    let original_position = winsaveview()

    " Set our cursor position to the top so we can normalize our search results
    call setpos('.', [0, 0, 0, 0])

    " Search for our first and last use statements
    let first_use = search('\(^\|\r\|\n\)\s*use \(.\{-}\)\_s*;', 'n')
    let last_use = search('use \(.\{-}\)\_s*;\(\r\|\n\)*\([^use]\)', 'n')

    " Define our sort range
    let sort_range = first_use . ',' . last_use

    " Order our use statements based on our sort range
    execute sort_range . 'sort'

    " Restore our original cursor position
    call winrestview(original_position)

    " Restore our undo history
    silent! execute 'rundo ' . tmpundofile
    call delete(tmpundofile)
endfunction
