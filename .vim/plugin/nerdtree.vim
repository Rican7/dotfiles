"
" NERDTree configuration
"

" Ignore certain files/dirs from showing
let NERDTreeIgnore=['^tags$[[file]]', '^tags\.vendor$[[file]]']

" Toggle opening/closing of NERDTree
nmap <F2> :NERDTreeToggle<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Close VIM if the only open buffer left is NERDTree
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
