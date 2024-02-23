# vim: filetype=sh

# Bash profile
#
# This is where initialization commands go to setup our Bash shell environment.
#
# This file is executed, if located at `~/.bash_profile`, when Bash is invoked:
#  - As an interactive, login shell (or with the `--login` flag)
#    (and not in POSIX mode or via an `sh` name/alias)
#
# See https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

export STARTUP_FILE_LOADED_BASH_PROFILE=true

# Generic environment config
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Bash specific config
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
