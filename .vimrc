" http://py.vaults.ca/~x/python_and_vim.html

set guifont=Courier\ New:h10
set guioptions-=T

" Windows SWAP files
if has("win32") || has("win64")
   set directory=$TMP
else
   set directory=/tmp
end

set backspace=2 sts=0 ts=5 sw=5 smarttab noet ai nocp wrap
set ruler nowrap backspace=2 hidden showmatch matchtime=3
set wrap incsearch ignorecase hlsearch mouse=a
set updatecount=50 showmatch matchtime=3
set modeline modelines=5 nu spr
set iskeyword-=_
set t_Co=256

let mapleader=","
" go back # words
map <leader>b :b#<CR>
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

" http://vim.wikia.com/wiki/Open_SVN_diff_window
map <leader>d :vnew<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>ggdd

:nnoremap <leader>i :setl noai nocin nosi inde=<CR>

"highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" abbr epoch <C-R>=strftime('%s')<CR>
abbr Firephp PSU::get('firephp')

autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead,BufNewFile *.html set filetype=php

filetype indent on

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType make set noexpandtab

let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=0

autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set errorformat=%m\ in\ %f\ on\ line\ %l

let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
let g:FuzzyFinderOptions.Base.abbrev_map = { "^psu" : [ "/web/includes_psu/**/" ], "^igrad" : [ "/web/pscpages/webapp/igrad/**/" ], "^ape" : ["/web/pscpages/webapp/ape/**/"], }
nnoremap <silent> <C-n>      :FuzzyFinderBuffer<CR>
nnoremap <silent> <C-m>      :FuzzyFinderFile<CR>

set wildmenu
set wildmode=list:longest,full

function! MyTabOrComplete()
	let col = col('.')-1
		if !col || getline('.')[col-1] !~ '\k'
		return "\<tab>"
	else
		return "\<C-N>"
	endif
endfunction
inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

" gf helpers (goto file)
set path=includes/,,/web/includes_psu,/web/includes_psu/PSUModels,/web/pscpages/webapp/igrad/includes
set suffixesadd=.php,.class.php,.inc.php
set includeexpr=substitute(v:fname,'-$','','g')

syntax on
set background=dark
colorscheme railscasts
"colorscheme ir_black

"set t_Co=256
set ffs=unix,dos,mac

function TogglePasteMode ()
        if (&paste)
        set nopaste
        echo "paste mode off"
        else
        set paste
        echo "paste mode on"
        endif
        endfunction