" http://py.vaults.ca/~x/python_and_vim.html

" Windows vs Mac GUI settings
if has("win32") || has("win64")
	set guifont=Courier\ New:h10
	set guioptions-=T
else
	set guifont=Courier\ New:h14
	set guioptions-=T
end

" Windows SWAP files
if has("win32") || has("win64")
	set directory=$TMP
else
	set directory=/tmp
end

" Pathogen! https://github.com/tpope/vim-pathogen
call pathogen#infect()
call pathogen#helptags()

set backupcopy=yes " http://marc.info/?t=108316584200005&r=1&w=2
set backspace=2 sts=5 ts=5 sw=5 smarttab noet ai nocp wrap
set ruler nowrap backspace=2 hidden showmatch matchtime=3
set wrap incsearch ignorecase hlsearch
set updatecount=50 showmatch matchtime=3
set modeline modelines=5 nu spr
set iskeyword-=_
set t_Co=256

" Let the spacebar work as a leader without still moving forward a char
nnoremap <SPACE> <Nop>

" Define my leader
let mapleader=" "

" Tab mappings
nmap <C-t> :tabnew<CR>
nmap <S-t> :tabclose<CR>
nmap <S-Tab> :tabnext<CR>
"nmap <C-S-Tab> :tabprevious<CR>

" When entering a tab, set the wordking path to the buffers in the tab
"autocmd TabEnter * lcd %:p:h

" go back # words
map <leader>b :b#<CR>
nmap <silent> <leader>' /\v'[^']+'<CR>:nohl<CR>
nmap <silent> <leader>" /\v"[^"]+"<CR>:nohl<CR>

" paste and indent
map <leader>P P'[v']=
map <leader>p p'[v']=

" wordwraps a paragraph
map <leader>q gqap

" makes the current window wider by 10 characters
map <leader>] 10<C-W>>
" makes the current window smaller by 10 characters
map <leader>[ 10<C-W><

map <leader>v :call TogglePasteMode()<CR>

map <silent> <leader>l :nohl<CR>
map <silent> <leader>L :se nu!<CR>
nmap <leader>s :source ~/.vimrc<CR>

map K <Nop>

" Superuser Write! Woot! Thanks to @borkweb and reddit
cnoremap w!! w !sudo dd of=%

" http://vim.wikia.com/wiki/Open_SVN_diff_window
" map <leader>d :vnew<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>ggdd

:nnoremap <leader>i :setl noai nocin nosi inde=<CR>

"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead,BufNewFile *.html set filetype=php
autocmd BufRead,BufNewFile *.sass set filetype=css
autocmd BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile .*rc set filetype=sh

filetype indent on

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType make set noexpandtab

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=0
let php_folding=0

autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
nnoremap <silent> <C-n>      :FuzzyFinderBuffer<CR>
nnoremap <silent> <C-m>      :FuzzyFinderFile<CR>

set wildmenu
set wildmode=list:longest,full

syntax on
set background=dark

colorscheme railscasts

"colorscheme ir_black

"set t_Co=256
set ffs=unix,dos,mac

function! TogglePasteMode ()
	if (&paste)
		set nopaste
		echo "paste mode off"
     else
     	set paste
     	echo "paste mode on"
     endif
endfunction

" Change highlight colors for vimdiff
highlight DiffAdd cterm=none ctermfg=black ctermbg=Green gui=none guifg=black guibg=Green 
highlight DiffDelete cterm=none ctermfg=black ctermbg=Red gui=none guifg=black guibg=Red 
highlight DiffChange cterm=none ctermfg=black ctermbg=Yellow gui=none guifg=black guibg=Yellow 
highlight DiffText cterm=none ctermfg=black ctermbg=Magenta gui=none guifg=black guibg=Magenta

"
" TagBar commands
"

" TagBar command hotkey
nmap <F8> :TagbarToggle<CR>

"
" NERDTree commands
"

" Toggle opening/closing of NERDTree
nmap <F2> :NERDTreeToggle<CR>

" Open NERDTree if no files were specified on opening VIM
autocmd vimenter * if !argc() | NERDTree | endif

" Close VIM if the only open buffer left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
