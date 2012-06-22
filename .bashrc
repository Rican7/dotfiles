# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
     . /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
     . /etc/bash.bashrc
fi

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

# User specific aliases and functions
umask 002;

# Change bash prompt
#export PS1="[\u \W]\$ "
#export PS1="[\u \W]\$ "
export PS1="\[\e[0;36m\]\u\[\e[m\] \[\e[0;32m\]\W\[\e[m\] $ "

# Make tmux try to reconnect/reattach to an existing session, yet fallback if none are running
alias tmux="if tmux has; then tmux -2 attach; else tmux -2 new; fi"

# Make sass try to watch a default file (style.scss) by default
alias sass="sass --watch style.scss:style.css"

# Enable ls to show folder/file colors
export SHELL="/bin/bash"
eval `dircolors ~/.dircolors`
alias ls="ls --color"

# Export the EDITOR and VISUAL variables
export EDITOR="vim"
export VISUAL="vim"

# Enable java command line usage by adding the Cygpath equivalent of the windows classpath
export CLASSPATH=`cygpath -wp $CLASSPATH`
