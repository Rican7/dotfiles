"
" My Vim configuration
"
"
" NOTE: Other configuration files are loaded via the runtimepath.
"
" Relative to the runtimepath...
" - I've separated other global configurations into files in `plugin/init`
" - I've put plugin-specific configurations into files in `plugin`
" - I've put language specific files in `ftplugin` and `after/ftplugin`
"
" Check the aforementioned paths for a complete config.
"

" Define a local/device vimrc and runtimepath.
"
" Useful for device-specific configurations that I don't want to sync with my
" portable configurations.
if has("win32") || has("win64")
    let s:device_vimrc = $HOME."/_vim_device_rc"
    set runtimepath+=$HOME/vimfiles_device
    set runtimepath+=$HOME/vimfiles_device/after
else
    let s:device_vimrc = $HOME."/.vim_device_rc"
    set runtimepath+=$HOME/.vim_device
    set runtimepath+=$HOME/.vim_device/after
end


" Set common GUI options
if has("gui_running")
    set guioptions-=T " Remove GUI toolbar
    set guioptions-=r " Remove right-hand scrollbar
    set guioptions-=L " Remove left-hand scrollbar

    " Set initial size
    set lines=42 columns=150

    " Windows vs Mac GUI settings
    if has("win32") || has("win64")
        set guifont=Source\ Code\ Pro:h10
    else
        set guifont=Source\ Code\ Pro:h14
    end
endif

" Windows SWAP files
if has("win32") || has("win64")
    set directory=$TMP
else
    " Use two trailing slashes to trigger collision-free swap file naming
    set directory=/tmp//
end

" Ensure two trailing slashes to trigger collision-free swap file naming
" NOTE: We can use forward slashes (`//`) on Win32 also, which simplifies our
" regular expression, and its actually suggested
" (see :help directory)
let &directory = substitute(&directory, '\(\\\|\/\/\)*$', '\/\/', "")

" Set nocompatible BEFORE most other settings
" (Use Vim defaults = much better!)
set nocompatible

" Packages (`:help packages`)
packadd! matchit

" Behavior settings
set backspace=indent,eol,start " Backspace/delete like most apps
set tabstop=4 softtabstop=4 shiftwidth=4
set autoindent
set expandtab smarttab
set history=750 " Set the command history size
set showcmd
set ruler
set hidden
set showmatch matchtime=3
set wrap
set incsearch ignorecase hlsearch
set updatecount=50
set modeline modelines=5
set number relativenumber
set nofoldenable
set t_Co=256
set ffs=unix,dos,mac

" Set more useful default auto-format options
"
"  - `croq` makes comment formatting much more natural
"  - `l` helps prevent formatting entire lines when making an edit to an existing
" long line.
"  - `j` helps joining existing lines with comment leaders
set formatoptions+=croqjl

" Set a useful default for the textwidth, rather than the default of `0`, which
" effectively comes out to`79`
"
" See https://vi.stackexchange.com/q/9118/7236
set textwidth=80

" Change how Vim writes files
"
" See :help backup-table
" See http://marc.info/?t=108316584200005&r=1&w=2
set nobackup
set writebackup
set backupcopy=yes " Prevent attributes from being lost on some OSs (eg Windows)

" Set new split default locations
set splitright
set splitbelow

set wildmenu
set wildmode=list:longest,full

" Tag file settings
set tags+=./tags;/,./TAGS;/ " Recurse up the directory tree until finding a tags file
set tags+=./tags.vendor;/ " Add tag files for vendor dependencies, again with recursion up the tree

" Terminal
set termwinsize=10x0

" When Vim is started by reading from stdin (`echo 'foo' | vim -`), flag it as
" such, so that we can optionally configure and execute other behaviors with
" this in mind.
let g:stdin_mode = 0
autocmd StdinReadPre * let g:stdin_mode = 1

" Set the QuickFix and LocationList windows to toggle opening/closing after a
" command/result that would open them runs. (Open on results, close when empty)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Set the LocationList window to automatically close after the corresponding
" buffer has been closed
autocmd QuitPre * if empty(&buftype) | lclose | endif

" Status line badassery
set laststatus=2
set statusline=%f%m%r%h%w\ %<%=[Ln\ %l,\ Col\ %v](%p%%)\ -\ %{&l:expandtab?'Spaces':'Tabs'}\ %{shiftwidth()}\ -\ %Y\ (%{&ff}\|%{&fenc})

" 'ColorColumn' Line configuration
set colorcolumn=+1 " Set the color column to appear at the text-width's setting

" Line number configuration
if exists("&cursorlineopt")
    set cursorline
    set cursorlineopt=number
endif

" Colorscheme
syntax on
set background=dark
colorscheme railscasts

" Color theme overrides
highlight Normal ctermbg=NONE ctermfg=NONE guibg=Black guifg=#f2f2f2

" Set our status line's colors
hi StatusLine cterm=bold ctermbg=LightGray ctermfg=Black gui=bold guibg=LightGray guifg=Black
hi StatusLineNC cterm=NONE ctermbg=DarkGray ctermfg=Black gui=bold guibg=DarkGray guifg=Black
hi StatusLineTerm cterm=bold ctermbg=Cyan ctermfg=Black gui=bold guibg=Cyan guifg=Black
hi StatusLineTermNC cterm=NONE ctermbg=DarkCyan ctermfg=Black gui=bold guibg=DarkCyan guifg=Black
hi VertSplit cterm=NONE ctermbg=DarkGray ctermfg=Black gui=NONE guibg=DarkGray guifg=Black

" 'ColorColumn' Line colors
hi ColorColumn term=reverse ctermbg=234 guibg=#1c1c1c ctermfg=NONE guifg=NONE

" Line number colors
hi LineNr ctermbg=232 ctermfg=159 guibg=#080808 guifg=LightBlue
hi CursorLineNr cterm=bold ctermfg=14 gui=bold guifg=Cyan

" Change highlight colors for vimdiff
hi DiffAdd term=bold ctermbg=22 ctermfg=NONE guibg=DarkGreen guifg=NONE
hi DiffDelete term=bold ctermbg=52 ctermfg=NONE guibg=Brown guifg=NONE
hi DiffChange term=bold ctermbg=58 ctermfg=NONE guibg=DarkOrange guifg=NONE
hi DiffText term=reverse cterm=bold ctermbg=DarkRed ctermfg=NONE gui=bold guibg=DarkRed guifg=NONE


"
" Folding Options
"

" Make folding indent sensitive
set foldmethod=indent

" Don't autofold anything (but I can still fold manually)
set foldlevel=100

" Don't open folds when you search into them
set foldopen-=search

" Don't open folds when you undo stuff
set foldopen-=undo


"
" Automatically triggered settings
"

filetype indent on
filetype plugin on

" Filetypes based on file extension
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
autocmd BufRead,BufNewFile *.sass set filetype=css
autocmd BufRead,BufNewFile *.scss set filetype=css
autocmd BufRead,BufNewFile .*rc set filetype=sh
autocmd BufRead,BufNewFile .*virc,.*vimrc set filetype=vim
autocmd BufRead,BufNewFile *.markdown,*.mdown,*.mkd,*.mkdn,*.md set filetype=markdown
autocmd BufRead,BufNewFile *.gradle set filetype=groovy

set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc

" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath splits)
"
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

" Potentially load a device vimrc
if filereadable(s:device_vimrc)
    exec "source " . escape(s:device_vimrc, ' ')
endif
