# vim: filetype=sh

# Bash "Run Commands (RC)" (or configuration)
#
# This is where initialization commands go to setup our Bash shell.
#
# This file is executed, if located at `~/.bashrc`, when Bash is invoked:
#  - As an interactive, non-login shell
#    (and not in POSIX mode or via an `sh` name/alias)
#  - When Bash detects that it's being run via a remote shell daemon (rshd/sshd)
#
# See https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

export STARTUP_FILE_LOADED_BASHRC=true

#
# Check that our profile has been loaded, since our config depends on it.
#
# NOTE: This is here because startup file loading semantics are confusing,
# non-intuitive, and can be application-specific.
#
# Notably, this configuration file (`~/.bashrc`) is loaded, but the profile
# (`~/.bash_profile`) file is NOT loaded, when a command is given to `ssh` OR
# during an `scp` operation, even though those are NOT "interactive" shell
# contexts!
#
# See:
#  - https://unix.stackexchange.com/q/332531
#  - https://unix.stackexchange.com/a/587218
#
# The intention of this setup is to load these files more consistently.
#
if [ "$STARTUP_FILE_LOADED_BASH_PROFILE" != true ]; then
  # Source our profile
  source ~/.bash_profile

  # Return to prevent recursion, as our profile also loads this file!
  return
fi

#
# Check BASH version and warn if it's old
#
if (( BASH_VERSINFO < 4 )); then
  printf -- "\n------------------------------------------------------------------------------------------\n"
  echo "WARNING! You're running Bash version '${BASH_VERSION}'."
  echo ''
  echo "Version 4 or later is expected by '${BASH_SOURCE}' and it's sub-scripts!"
  printf -- "------------------------------------------------------------------------------------------\n\n"
fi

export USER_RCFILE="$BASH_SOURCE"

#
# Source system definitions
#
for filename in /etc/bashrc /etc/bash.bashrc
do
  if [ -f "$filename" ]; then
    source "$filename"
    export SYSTEM_RCFILE="$filename"
    break
  fi
done;
unset filename # Don't keep this around in shells

# User specific aliases and functions
umask 002;

##########################
## Modify PATH Variable ##
##########################
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:~/.local/bin:~/local/bin:/usr/bin:/usr/sbin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH" # "heroku" - Heroku CLI
export PATH="$HOME/.phpenv/bin:$HOME/.phpenv/shims:$PATH" # "phpenv" - PHP Environment
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH" # "rbenv" - Ruby Environment
export PATH="$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin:$PATH" # Global composer package executable binaries
export PATH="vendor/bin:$PATH" # Local composer package executable binaries
export PATH="./bin:$PATH" # Local executable binaries

# Create some useful identifiers
export HOSTNAME_SHORT="${HOSTNAME%%.*}"
export GITHUB_USERNAME="Rican7"
export GITHUB_USER_URL="github.com/${GITHUB_USERNAME}"

#
# Enhance and "fix" bash command history
#
export HISTPARENTDIR="${HOME}/.bash_history.d"
export HISTFILEBASENAME="${HOSTNAME_SHORT}"
export HISTFILE="${HISTPARENTDIR}/$(date -u +%Y/%m/%d)/${HISTFILEBASENAME}" # Thanks https://twitter.com/michaelhoffman/status/639178145673932800
export HISTDIR="$(dirname ${HISTFILE})"
export HISTCONTROL=ignoredups:erasedups # Prevent duplicate entries
export HISTIGNORE="ls:la:pwd:[bf]g:clear:exit" # Prevent certain commands from being recorded in history
export HISTSIZE=100000 # Enable a large history
export HISTFILESIZE=100000 # Enable a large history
export PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}" # Make sure the current session appends entries to existing ones
shopt -s histappend # Have concurrent sessions append to history, instead of overwriting it

# Create the HISTDIR directory if it doesn't exist
if [ ! -e "${HISTDIR}" ]; then
    mkdir -m 700 -p "$HISTDIR"
fi

HISTFILES=("${HISTPARENTDIR}"/**/**/*/"${HISTFILEBASENAME}")

#
# Improve history by loading multiple of our latest history files
#
# This logic enables the keeping of history in multiple separate files, while
# still getting a useful history that doesn't break whenever a new history file
# is used for separation
#
if [ ${#HISTFILES[@]} -gt 0 ]; then
    # Make a temporary pipe to collect history from multiple pipes
    TMP_HISTFILE="$(mktemp)"

    # Cat all of the history files, limit based on the defined history size, and
    # store them into the temporary history file
    cat "${HISTFILES[@]}" | head -n $HISTSIZE > "$TMP_HISTFILE"

    # Load history from the "collected history" file and remove it
    history -n "$TMP_HISTFILE" # A "real" file is needed... pipes won't work
    rm "$TMP_HISTFILE"
fi


#
# Autocompletion
#
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source my own custom bash completion scripts
for filename in ${HOME}/bash_completion.d/*
do
    # Source the file (add the autocompletion scheme to bash "complete")
    source "$filename"
done;
unset filename # Don't keep this around in shells

# Autocomplete my SSH hosts
# Originally found here: https://coderwall.com/p/ezpvpa
# Modified to not grab the catch-all "*" definition
complete -o default -o nospace -W "$(awk '/^Host [^\*]/ {print $2}' < "$HOME"/.ssh/config)" scp sftp ssh


#
# Environment Variables
#
# Let's define our shell for continuity
export SHELL="$(which bash)"

# Export the EDITOR and VISUAL variables
export EDITOR="vim"
export VISUAL="vim"
export SVN_EDITOR="vim"

# Change bash prompt and color
export PS1="\[\e[0;36m\]\u\[\e[m\]\[\e[0;34m\]@\h\[\e[m\] \[\e[0;32m\]\W\[\e[m\] \$ "

# Define a common "PAGER" for other utilities
export PAGER='less -FRSX'

# Suppress our DOS file warnings when running Cygwin
export CYGWIN="nodosfilewarning"

# Suppress NPM funding messages
#
# Use an environment variable instead of the `~/.npmrc` file, because that file
# can contain auth details that shouldn't live in my dotfiles or in a repo.
#
# See:
#  - https://blog.npmjs.org/post/188841555980/updates-to-community-docs-more
#  - https://github.com/npm/cli/issues/595#issuecomment-565929067
#  - https://docs.npmjs.com/cli/v10/using-npm/config#environment-variables
export npm_config_fund=false

# Guard for interactive shells
#
# The commands executed herein are only safe for interactive shells
#
# See:
#  - https://unix.stackexchange.com/questions/257571/why-does-bashrc-check-whether-the-current-shell-is-interactive
#  - https://www.gnu.org/software/bash/manual/html_node/Is-this-Shell-Interactive_003f.html
if [[ $- = *i* ]]; then
    # disable XON/XOFF flow control
    # (stop `ctrl+s` from freezing output)
    stty -ixon
fi

# Let's define what commands exist
hash phpenv    2>/dev/null && phpenv=true || phpenv=false
hash rbenv     2>/dev/null && rbenv=true || rbenv=false
hash jump      2>/dev/null && jump=true || jump=false
hash fd        2>/dev/null && fd=true || fd=false

# Initialize phpenv
if $phpenv ; then
    eval "$(phpenv init -)"
fi

# Initialize rbenv
if $rbenv ; then
    eval "$(rbenv init -)"
fi

# Initialize jump
if $jump ; then
    eval "$(jump shell)"
fi

if $fd ; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --follow --exclude '.git'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# SSH Agent at Login
# Thanks to http://mah.everybody.org/docs/ssh#run-ssh-agent
readonly SSH_ENV="$HOME/.ssh/environment"
readonly SSH_IDENTITY_FILES="$HOME/.ssh/id_*"
function ssh_add_identities() {
    # If on macOS
    if [[ $OSTYPE == darwin* ]] ; then
      # The `-A` switch has been deprecated in macOS Monterey (Darwin 21.0.0)
      if [ "$(echo "$(uname -r | cut -d'.' -f1) >= 21" | bc)" = 1 ] ; then
        /usr/bin/ssh-add --apple-load-keychain;
      else
        /usr/bin/ssh-add -A; # Add all from "Keychain"
      fi
    else
        /usr/bin/ssh-add;
    fi
}
function ssh_start_agent() {
    printf "Initialising new SSH agent... "
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    printf "Succeeded!\n"
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null

    ssh_add_identities;
}
# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" > /dev/null

    # If the SSH agent is running
    #
    # NOTE: ps ${SSH_AGENT_PID} doesn't work under cywgin
    if ps -ef | grep "${SSH_AGENT_PID}" | grep 'ssh-agent$' > /dev/null ; then

      # If our agent has no identities, and identity files exist...
      #
      # NOTE: This was added because newer versions of macOS will start an
      # ssh-agent at startup, yet won't necessarily add existing (or keychained)
      # identities. So, while the SSH agent will report as running, we still
      # want to add our own identities.
      #
      # This is a more resilient strategy anyway, although it does require an
      # additional check on each bash instance start.
      if ! ssh-add -l >/dev/null && stat -t "${SSH_IDENTITY_FILES}" >/dev/null 2>&1 ; then
        ssh_add_identities
      fi

    else
        ssh_start_agent;
    fi
else
    ssh_start_agent;
fi

# Let's source an optional device-specific bash config file
if [ -f ~/.bash_device_rc ]; then
    source ~/.bash_device_rc
fi

# Load our aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi
