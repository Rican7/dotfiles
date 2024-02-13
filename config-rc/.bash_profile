# bash
# (NOTE: Don't modify the above line... it tells Vim which "sh" type is in use)
# vim: syntax=sh filetype=sh

# Generic environment config
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Bash specific config
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
