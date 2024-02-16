# Non-shell-specific profile
#
# This is a useful place to define common environment variables that are needed
# regardless of shell-type (not just for Bash), or even graphical environments,
# as some linux display managers will execute this also.
#
# NOTE: The commands used here should attempt to be POSIX compliant.
#
# See: https://help.ubuntu.com/community/EnvironmentVariables#A.2BAH4-.2F.profile

# We attempt to use BASH_SOURCE, since it works when sourced, but we fallback
# for other shells with POSIX variable substitution compatibility.
SCRIPT="${BASH_SOURCE:-$0}"
SCRIPT_DIR="$(dirname -- "$SCRIPT")"
DOTFILES_DIR=""

# `realpath` isn't in POSIX, but `hash` is...
hash realpath 2>/dev/null && realpath=true || realpath=false

# If we have realpath
if $realpath; then
    SCRIPT="$(realpath -- "$SCRIPT")"
    SCRIPT_DIR="$(dirname -- "$SCRIPT")"
    DOTFILES_DIR="$(dirname -- "$SCRIPT_DIR")"

    export DOTFILES_DIR
fi

# Define some things based on whether or not we know where our dotfiles are
if [ -n "$DOTFILES_DIR" ]; then
    export XDG_CONFIG_HOME="$DOTFILES_DIR/.config"
else
    export XDG_CONFIG_HOME="$HOME/.config"
fi

# Source an optional device-specific profile file
if [ -f ~/.device_profile ]; then
    . ~/.device_profile
fi
