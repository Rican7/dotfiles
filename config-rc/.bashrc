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
export PATH="/usr/local/bin:/usr/local/sbin/:/usr/local/mysql/bin/:/opt/local/bin:/opt/local/sbin:~/local/bin:/usr/bin:/usr/sbin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH" # "heroku" - Heroku CLI
export PATH="$HOME/.phpenv/bin:$HOME/.phpenv/shims:$PATH" # "phpenv" - PHP Environment
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH" # "rbenv" - Ruby Environment
export PATH="$HOME/.composer/vendor/bin:$PATH" # Global composer package executable binaries
export PATH="vendor/bin:$PATH" # Local composer package executable binaries
export PATH="./bin:$PATH" # Local executable binaries


#
# Autocompletion
#
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

	# If we have a global autocompletion directory
	if [ -d /etc/bash_completion.d ]; then
	     # For each file in the autocompletion directory
	     for filename in /etc/bash_completion.d/*
	     do
		     # Source the file (add the autocompletion scheme to bash "complete")
		     . $filename
	     done;
	fi
fi

# Source my own custom bash completion scripts
for filename in ${HOME}/bash_completion.d/*
do
	# Source the file (add the autocompletion scheme to bash "complete")
	source $filename
done;

# Autocomplete my SSH hosts
# Originally found here: https://coderwall.com/p/ezpvpa
# Modified to not grab the catch-all "*" definition
complete -o default -o nospace -W "$(awk '/^Host [^\*]/ {print $2}' < $HOME/.ssh/config)" scp sftp ssh


#
# Environment Variables
#
# Let's define our shell for continuity
export SHELL="/bin/bash"

# Export the EDITOR and VISUAL variables
export EDITOR="vim"
export VISUAL="vim"
export SVN_EDITOR="vim"

# Change bash prompt and color
export PS1="\[\e[0;36m\]\u\[\e[m\]\[\e[0;34m\]@\h\[\e[m\] \[\e[0;32m\]\W\[\e[m\] $ "

# Suppress our DOS file warnings when running Cygwin
export CYGWIN="nodosfilewarning"


#
# Function aliases
#
# Let's define what commands exist
hash tmux		2>/dev/null && tmux=true || tmux=false
hash sass		2>/dev/null && sass=true || sass=false
hash dircolors 2>/dev/null && dircolors=true || dircolors=false
hash apt-cyg	2>/dev/null && aptcyg=true || aptcyg=false
hash phpenv	2>/dev/null && phpenv=true || phpenv=false

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
alias la="ls -la"
alias vi="vim"
alias view="vim -R"
alias sudo="sudo " # Alias sudo so it can keep its subcommand's aliasing (http://blog.edwards-research.com/2010/07/keeping-aliases-with-sudo-sort-of/)
alias explore="open -e"
alias pack="ack --pager='less -R'"
alias src="source ~/.bash_profile"
alias srcg="source /etc/profile"

# Copy/remake of "http://rage.thewaffleshop.net/"
# Originally found from @abackstrom (https://twitter.com/abackstrom/status/232898857837662208)
alias fuck="curl -s rage.metroserve.me/?format=plain"

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

# Z command (similar to J/AutoJump)
export _Z_CMD="j" # I'm used to j...
source ~/local/bash/z.sh

# Initialize phpenv
if $phpenv ; then
     eval "$(phpenv init -)"
fi

# SSH Agent at Login
# Thanks to http://mah.everybody.org/docs/ssh#run-ssh-agent
SSH_ENV="$HOME/.ssh/environment"
function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi



# Let's source an optional device-specific bash config file
if [ -f ~/.bash_device_rc ]; then
     . ~/.bash_device_rc
fi
