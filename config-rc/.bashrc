# .bashrc

#
# Source global definitions
#
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
elif [ -f /etc/bash.bashrc ]; then
    source /etc/bash.bashrc
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
if [ -e "${HOME}/.git-completion.bash" ]; then
    source "${HOME}"/.git-completion.bash
fi

# Source my own custom bash completion scripts
for filename in ${HOME}/bash_completion.d/*
do
    # Source the file (add the autocompletion scheme to bash "complete")
    source "$filename"
done;

# Autocomplete my SSH hosts
# Originally found here: https://coderwall.com/p/ezpvpa
# Modified to not grab the catch-all "*" definition
complete -o default -o nospace -W "$(awk '/^Host [^\*]/ {print $2}' < "$HOME"/.ssh/config)" scp sftp ssh


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
export PS1="\[\e[0;36m\]\u\[\e[m\]\[\e[0;34m\]@\h\[\e[m\] \[\e[0;32m\]\W\[\e[m\] \$ "

# Suppress our DOS file warnings when running Cygwin
export CYGWIN="nodosfilewarning"

# Let's define what commands exist
hash phpenv    2>/dev/null && phpenv=true || phpenv=false
hash rbenv     2>/dev/null && rbenv=true || rbenv=false

# Z command (similar to J/AutoJump)
export _Z_CMD="j" # I'm used to j...
source ~/local/bash/z.sh

# Initialize phpenv
if $phpenv ; then
    eval "$(phpenv init -)"
fi

# Initialize rbenv
if $rbenv ; then
    eval "$(rbenv init -)"
fi

# SSH Agent at Login
# Thanks to http://mah.everybody.org/docs/ssh#run-ssh-agent
SSH_ENV="$HOME/.ssh/environment"
function start_agent() {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" > /dev/null

    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep "${SSH_AGENT_PID}" | grep 'ssh-agent$' > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Load our aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# Let's source an optional device-specific bash config file
if [ -f ~/.bash_device_rc ]; then
    source ~/.bash_device_rc
fi
