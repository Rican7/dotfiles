# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
     . /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
     . /etc/bash.bashrc
fi

# User specific aliases and functions
umask 002;

##########################
## Modify PATH Variable ##
##########################
export PATH="/usr/local/bin:/usr/local/sbin/:/usr/local/mysql/bin/:/opt/local/bin:/opt/local/sbin:~/local/bin:$PATH"

# Grab smart autocompletion functions
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

# For each file in the autocompletion directory
for filename in /etc/bash_completion.d/*
do
	# Source the file (add the autocompletion scheme to bash "complete")
	. $filename
done;

# Let's define our shell for continuity
export SHELL="/bin/bash"

# Change bash prompt
#export PS1="[\u \W]\$ "
#export PS1="[\u \W]\$ "
export PS1="\[\e[0;36m\]\u\[\e[m\] \[\e[0;32m\]\W\[\e[m\] $ "

# Let's define what commands exist
hash tmux		2>/dev/null && tmux=true || tmux=false
hash sass		2>/dev/null && sass=true || sass=false
hash dircolors 2>/dev/null && dircolors=true || dircolors=false
hash cygpath	2>/dev/null && cygpath=true || cygpath=false

# Make tmux try to reconnect/reattach to an existing session, yet fallback if none are running
if $tmux ; then
	alias tmux="if tmux has; then tmux -2 attach; else tmux -2 new; fi"
fi

# Make sass try to watch a default file (style.scss) by default
if $sass ; then
	alias sass="sass --watch style.scss:style.css"
fi

# Enable ls to show folder/file colors
if $dircolors ; then
	[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
	[ -e "$DIR_COLORS" ] || DIR_COLORS=""
	eval "`dircolors -b $DIR_COLORS`"
	alias ls="ls --color"
fi

# Export the EDITOR and VISUAL variables
export EDITOR="vim"
export VISUAL="vim"

# Enable java command line usage by adding the Cygpath equivalent of the windows classpath
if $cygpath ; then
	export CLASSPATH=`cygpath -wp $CLASSPATH`
fi
