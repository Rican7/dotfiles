#! /usr/bin/env bash
#
# Script to install all of the correct symlinks (syncing 
#
#

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
	"$HOME/.bash_profile"
	"$HOME/.bashrc"
	"$HOME/.gitconfig"
	"$HOME/.minttyrc"
	"$HOME/.vim"
	"$HOME/.vimrc"
	"$HOME/local/bin"
	"/etc/bash_completion.d"
);

# Define an array of Windows/Cygwin ONLY files/directories
cygFileLocations=(
	"$HOME/vimfiles"
	"$HOME/_vimrc"
);

# Define an array containing the destination of the Windows/Cygwin ONLY files/directories for linking
# MUST ALIGN WITH cygFilesSources
cygFileDestinations=(
	".vim"
	".vimrc"
);

# Create a function to remove the passed target
function removeTarget() {
	# The target should be the first (only) argument
	target=$1

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
	fi
}

# Let's loop through each file/directory
for target in "${filesDirectories[@]}"
do
	# Get the basename
	baseName=$(basename "$target")

	# Use the removeTarget function and pass the target as an argument
	removeTarget $target

	# Relink the file
	ln -s $gitboxDir/$baseName $target

	# Verbose info
	if $verbose ; then
		echo -e " $gitboxDir/$baseName has been linked to $target"
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
