"
" Mappings
"

" Let the spacebar work as a leader without still moving forward a char
nnoremap <SPACE> <Nop>

" Define my leader
let mapleader=" "

" Un-map ctrl-n on start
autocmd VimEnter * nunmap <C-n>

" Remap the Ctrl-a mapping (increment) to Ctrl-s (opposite of Ctrl-x) to allow
" for incrementing while using tmux/screen with a `Ctrl-a` leader
nnoremap <C-s> <C-a>

" Set current directory to the path of the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" Set current directory of the window to the path of the current file
nnoremap <leader>CD :lcd %:p:h<CR>:pwd<CR>

" Tab mappings
nmap <C-t> :tabnew<CR>
nmap <S-t> :tabclose<CR>
nmap <S-Tab> :tabnext<CR>
"nmap <C-S-Tab> :tabprevious<CR>

" When entering a tab, set the working path to the buffers in the tab
"autocmd TabEnter * lcd %:p:h

" Go to next quoted entry
nmap <silent> <leader>' /\v'[^']+'<CR>:nohl<CR>
nmap <silent> <leader>" /\v"[^"]+"<CR>:nohl<CR>

" Go to next paren-surrounded entry
nmap <silent> <leader>( /\v\([^\(]+\)<CR>:nohl<CR>
nmap <silent> <leader>) /\v\([^\)]+\)/e<CR>:nohl<CR>

" Go to next curly-brace-surrounded entry
nmap <silent> <leader>{ /\v\{[^\{]+\}<CR>:nohl<CR>
nmap <silent> <leader>} /\v\{[^\{]+\}/e<CR>:nohl<CR>

" Go to next square-brace-surrounded entry
nmap <silent> <leader>[ /\v\[[^\[]+\]<CR>:nohl<CR>
nmap <silent> <leader>] /\v\[[^\]]+\]/e<CR>:nohl<CR>

" Enable and disable Paste Mode
map <leader>v :call TogglePasteMode()<CR>

" Enable and disable hard/soft tabs
map <leader>t :call ToggleExpandTab()<CR>

" Paste and select the text
map <leader>P P'[v']
map <leader>p p'[v']

" Toggle search highlighting
map <silent> <leader>l :se hls!<CR>

" Return highlighting to normal on search
nnoremap / :set hlsearch<CR>/
nnoremap <silent> n :set hlsearch<CR>n
nnoremap <silent> N :set hlsearch<CR>N

" Toggle line-numbering
" map <silent> <leader>n :se nu!<CR>
map <silent> <leader>n :call ToggleShowNumbers()<CR>

" Search for currently selected text
vnoremap / "hy/<C-r>h

" Search and replace for currently selected text
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>

" Source our vimrc
nmap <leader>s :source $MYVIMRC<CR>

" Superuser Write! Woot! Thanks to @borkweb and reddit
cnoremap w!! w !sudo dd of=%

" wordwraps a paragraph
map <leader>q gqap
vnoremap <leader>q gq

" go back # words
map <leader>b :b#<CR>

" go forward # words
map <leader>w :w#<CR>

" Re-map the quick split key-binds to create new buffers
map <C-w>v :vnew<CR>
map <C-w>s :new<CR>

" makes the current vsplit window wider by 10 characters
map <leader><Right> 10<C-W>>
" makes the current vsplit window smaller by 10 characters
map <leader><Left> 10<C-W><
" makes the current hsplit window larger by 10 characters
map <leader><Up> 10<C-W>+
" makes the current hsplit window smaller by 10 characters
map <leader><Down> 10<C-W>-

" Turn off the line-deleting functions. They're annoying when you make a mistake
map K <Nop>
map J <Nop>

" Center our screen on the found item when moving through search results
map N Nzz
map n nzz


"
" Command mappings
"
command! RemoveHiddenBuffers :call RemoveHiddenBuffers()


"
" Insert mappings
"

" Insert the file's name
inoremap \fn <C-R>=expand("%:t:r")<CR>

" Insert the directory's name
inoremap \dn <C-R>=expand("%:p:h:t")<CR>

