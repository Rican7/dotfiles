"
" ctrlp configuration
"

" Configure CtrlP for the path to search in on invocation
let g:ctrlp_working_path_mode = 'a'

" Set CtrlP to update results lazily, so that typing isn't as easily interrupted
" (TODO: Remove this if/when CtrlP MATCHING becomes async)
let g:ctrlp_lazy_update=100

" Turn on async mode
let g:ctrlp_user_command_async=1

if (1 == executable('rg'))
    " If 'rg' (ripgrep) is installed, use it as the CtrlP indexer. :)
    let g:ctrlp_user_command = 'rg -i --color=never --files --iglob "!*.{min.*,dat,exe,gif,png,jpeg,jpg,ico,bmp}" %s'
    let g:ctrlp_use_caching = 0 " rg is fast enough, so we don't need caching
elseif (1 == executable('sift'))
    " If 'sift' is installed, use it as the CtrlP indexer. :)
    let g:ctrlp_user_command = 'sift -i --no-conf --no-color --no-group --targets --exclude-dirs=".git" --exclude-ext="min.js,dat,exe,gif,png,jpeg,jpg,ico" %s'
    let g:ctrlp_use_caching = 0 " sift is fast enough, so we don't need caching
elseif (1 == executable('ack'))
    " If 'ack' is installed, use it as the CtrlP indexer. :)
    let g:ctrlp_user_command = 'ack -i --noenv --nocolor --nogroup -f %s'
endif
