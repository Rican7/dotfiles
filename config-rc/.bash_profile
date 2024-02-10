# bash
# (NOTE: Don't modify the above line... it tells Vim which "sh" type is in use)
# vim: syntax=sh filetype=sh

# Source an optional device-specific profile file
if [ -f ~/.device_profile ]; then
    source ~/.device_profile
fi

# Bash specific config
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
