# .bashrc

#
# Source global definitions
#
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
if [ -e "${HOME}/.git-completion.bash" ]; then
	source "${HOME}"/.git-completion.bash
fi
if [ -e /usr/local/git/contrib/completion/git-completion.bash ]; then
	source /usr/local/git/contrib/completion/git-completion.bash
fi

# If we're NOT running on Debian based distributions
if [ ! -f /etc/debian_version ]; then
	# Grab smart autocompletion functions

	# For each file in the autocompletion directory
	for filename in /etc/bash_completion.d/*
	do
		# Source the file (add the autocompletion scheme to bash "complete")
		. $filename
	done;
fi

# Let's define our shell for continuity
export SHELL="/bin/bash"

# Export the EDITOR and VISUAL variables
export EDITOR="vim"
export VISUAL="vim"
export SVN_EDITOR="vim"

# Change bash prompt and color
#export PS1="[\u \W]\$ "
#export PS1="\e[0;36m\u\e[m \e[0;32m\W\e[m \$ "
export PS1="\[\e[0;36m\]\u\[\e[m\]\[\e[0;34m\]@\h\[\e[m\] \[\e[0;32m\]\W\[\e[m\] $ "

# Let's define what commands exist
hash tmux		2>/dev/null && tmux=true || tmux=false
hash sass		2>/dev/null && sass=true || sass=false
hash dircolors 2>/dev/null && dircolors=true || dircolors=false
hash apt-cyg	2>/dev/null && aptcyg=true || aptcyg=false

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

# Let's define some other aliases
alias vi="vim"
alias view="vim -R"
alias sudo="sudo " # Alias sudo so it can keep its subcommand's aliasing (http://blog.edwards-research.com/2010/07/keeping-aliases-with-sudo-sort-of/)
alias explore="open -e"

# Check if we're running CYGWIN
if [[ $OSTYPE == "cygwin" ]] ; then
	# Enable java command line usage under Cygwin
	alias java="winrun java"

	# Do we have apt-cyg?
	if $aptcyg ; then
		# Alias cygpath to a good mirror
		alias apt-cyg="apt-cyg -m ftp://cygwin.mirrorcatalogs.com/cygwin/"
		alias apt-cygports="apt-cyg -m ftp://ftp.cygwinports.org/pub/cygwinports/"
	fi
fi

# Check if we're running OS X
if [[ $OSTYPE == darwin* ]] ; then
	# Don't use our custom "open" script; Fall back to stock
	alias open="/usr/bin/open"
	alias explore="/usr/bin/open ."
fi

# AutoJump!
source ~/local/bash/autojump.bash

# Let's source an optional device-specific bash config file
if [ -f ~/.bash_device_rc ]; then
     . ~/.bash_device_rc
fi
