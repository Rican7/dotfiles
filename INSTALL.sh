#! /usr/bin/env bash
#
# Script to install all of the correct symlinks (syncing 
#
#

# Define constants
CONFIGDIR='./config-rc'

# Declare variables
possibleParameters="v"
verbose=false;

# Let's set some values based on the parameters
while getopts "$possibleParameters" opt; do
	case $opt in
		v)	verbose=true;;
		\?)	echo "Invalid option: -$OPTARG"; exit;;
	esac
done

# Get the current directory
gitboxDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define an array of files/directories
filesDirectories=(
	"$HOME/.vim"
	"$HOME/local"
	"/etc/bash_completion.d"
);

# Define an array for all of the config-rc files
configFiles=()
# Let's go through all of the files in the config-rc directory
shopt -s dotglob # Allow * to match hidden files
for filename in $CONFIGDIR/*
do
	configFiles+=($filename)
done;
shopt -u dotglob # Undo the allowing of * to match hidden files

# Define an array of Windows/Cygwin ONLY files/directories
cygFileLocations=(
	"$HOME/_vimrc"
	"$HOME/vimfiles"
);

# Define an array containing the destination of the Windows/Cygwin ONLY files/directories for linking
# MUST ALIGN WITH cygFilesSources
cygFileDestinations=(
	".vimrc"
	".vim"
);

# Create a function to remove the passed target
function removeTarget() {
	# The target should be the first (only) argument
	local target=$1

	# If the target is a file
	if [ -f "$target" ] ; then
		# Remove the original file... we're gonna link it instead
		rm $target

		# Verbose info
		if $verbose ; then
			echo -e "file \t\t$target removed"
		fi
	# If the target is a directory
	elif [ -d "$target" ] ; then
		# Remove the original directory... we're gonna link it instead
		rm -r $target

		# Verbose info
		if $verbose ; then
			echo -e "directory \t$target removed"
		fi
	elif [ -L "$target" ] && [ ! -e "$target" ] ; then
		# Remove the broken link
		rm $target

		# Verbose info
		if $verbose ; then
			echo -e "broken link \t$target removed"
		fi
	fi
}

# Let's loop through each file/directory
for target in "${filesDirectories[@]}"
do
	# Get the basename
	baseName=$(basename "$target")

	# Let's make SURE that we have write permissions
	# If the file doesn't exist, let's just go ahead and make the link anyway
	if [ -w "$target" ] || [ ! -e "$target" ] ; then
		# Use the removeTarget function and pass the target as an argument
		removeTarget $target

		# Relink the file
		ln -s $gitboxDir/$baseName $target

		# Verbose info
		if $verbose ; then
			echo -e " $gitboxDir/$baseName has been linked to $target"
		fi
	fi
done;

# Let's loop through each config file
for target in "${configFiles[@]}"
do
	# Get the basename
	baseName=$(basename "$target")

	# Let's make SURE that we have write permissions
	# If the file doesn't exist, let's just go ahead and make the link anyway
	if [ -w "$target" ] || [ ! -e "$target" ] ; then
		# Use the removeTarget function
		removeTarget $HOME/$baseName

		# Relink the file
		ln -s $gitboxDir/$target $HOME/$baseName

		# Verbose info
		if $verbose ; then
			echo -e " $gitboxDir/$target has been linked to $HOME/$baseName"
		fi
	fi
done;

# Check if we're running CYGWIN
if [[ $OSTYPE == "cygwin" ]] ; then
	# Get the windows style home directory
	windowsStyleHome=$(cygpath -w $HOME);

	# Create a quick counter, to keep our two cygFile arrays aligned
	count=0

	# Let's loop through each file/directory
	for cygTarget in "${cygFileLocations[@]}"
	do
		# Get the windows target path
		windowsTargetPath=$(cygpath -w $cygTarget);

		# Get the windows gitbox directory path
		windowsGitboxPath=$(cygpath -w $gitboxDir);

		# Use the removeTarget function and pass the target as an argument
		removeTarget $cygTarget

		# Verbose info
		if [ $verbose != true ] ; then
			# Suppress the output
			outputSuppressor='>nul'
		fi

		# Use cmd (windows native command prompt) to setup Windows NT Symbolic Links
		cmd /c mklink "$windowsTargetPath" "$windowsGitboxPath\\${cygFileDestinations[$count]}" $outputSuppressor

		# Increment the counter
		count=$[$count+1]
	done;
fi
