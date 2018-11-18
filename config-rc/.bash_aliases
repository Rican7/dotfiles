#
# Function aliases
#
# vim: syntax=sh filetype=sh

# Let's define what commands exist
hash sass      2>/dev/null && sass=true || sass=false
hash dircolors 2>/dev/null && dircolors=true || dircolors=false
hash emux      2>/dev/null && emux=true || emux=false


# Make sass try to watch a default file (style.scss) by default
if $sass ; then
    alias sass="sass --watch style.scss:style.css"
fi

# Enable ls to show folder/file colors
if $dircolors ; then
    [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    eval "$(dircolors -b $DIR_COLORS)"

    alias ls="ls --color"
fi

if $emux ; then
    # Single quote this to delay expansion
    alias emux-this='emux "$(basename "$(pwd)")"'
    alias tmux-this='emux-this'
fi

alias la="ls -la"
alias vi="vim"
alias view="vim -R"
alias explore="open -e"
alias pack="ack --pager='less -R'"
alias src="source ~/.bash_profile"
alias srcg="source /etc/profile"
alias stripbinary="tr -cd '[:print:]\n'"

# Go(lang) aliases
alias golisttypes="sift --no-group --filename --no-line-number --ext='go' --exclude-files='*_test.go' '^(\s)?type .*'"
alias goliststructs="sift --no-group --filename --no-line-number --ext='go' --exclude-files='*_test.go' 'type .* struct {'"
alias golistinterfaces="sift --no-group --filename --no-line-number --ext='go' --exclude-files='*_test.go' 'type .* interface {'"
alias golistcleantogodoc="sed 's/type\s\(.*\?\)\s.*/\1/g' | sed 's/\s.*//' | sed 's/\(\(\w\+\/\)\?\(\w\+\)\/\)\?\w\+\.go:/\3./g' | sed 's/^\.//g' | xargs -L 1 go doc 2>/dev/null"
alias godoclistclean="sift --no-group --no-line-number --no-color '^(package|type|}|\t)'"
alias godoctypes="golisttypes | golistcleantogodoc"
alias godocstructs="goliststructs | golistcleantogodoc"
alias godocinterfaces="golistinterfaces | golistcleantogodoc"
alias golisttypesverbose="godoctypes | godoclistclean"
alias goliststructsverbose="godocstructs | godoclistclean"
alias golistinterfacesverbose="godocinterfaces | godoclistclean"
alias golistdeps="go list -f '{{ join .Deps \"\n\" }}'"
golistdepsordered() { golistdeps "${1}" | sort -n | uniq; }
golistdepsgrouped() { golistdepsordered "${1}" | grep -v '^[^internal].*\.'; echo; golistdepsordered "${1}" | grep '^[^internal].*\.'; }

# Alias sudo so it can keep its subcommand's aliasing
# (http://blog.edwards-research.com/2010/07/keeping-aliases-with-sudo-sort-of/)
alias sudo="sudo "

# Check if an argument works first
if ls --group-directories-first . >/dev/null 2>&1; then
    alias la="${BASH_ALIASES[la]} --group-directories-first"
fi

# Copy/remake of "http://rage.thewaffleshop.net/"
# Originally found from @abackstrom (https://twitter.com/abackstrom/status/232898857837662208)
alias fuck="curl -s rage.metroserve.me/?format=plain"

# Cygwin/Windows specific aliases
if [[ $OSTYPE == "cygwin" ]] && [ -f ~/.bash_aliases.win ] ; then
    source ~/.bash_aliases.win
fi

# Darwin/Mac OS X specific aliases
if [[ $OSTYPE == darwin* ]] && [ -f ~/.bash_aliases.osx ] ; then
    source ~/.bash_aliases.osx
fi
