"
" NERDTree configuration
"

" Ignore certain files/dirs from showing
let NERDTreeIgnore=['^tags$[[file]]', '^tags\.vendor$[[file]]']

" Toggle opening/closing of NERDTree
nmap <F2> :NERDTreeToggle<CR>

" Open NERDTree if no files were specified on opening VIM
autocmd vimenter * if !argc() && !g:stdin_mode | NERDTree | endif

" Close VIM if the only open buffer left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
