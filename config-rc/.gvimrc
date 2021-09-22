"
" My gVim (GUI Vim) configuration
"

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
