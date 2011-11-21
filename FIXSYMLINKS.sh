#! /usr/bin/env bash
#
# Script to fix all of the symlinks that were synced, to the correct home values 
#
#

# Loop through each file in the usr local bin
for filename in /usr/local/bin/*
do
	# Get the symlink target
	target=$(readlink "$filename")

	# Check if file exists or not, if not, correct the link
	if [[ "$target" != "" ]] && [[ ! -f "$target" ]] && [[ ! -d "$target" ]] ; then
		# Get the links home path first
		baseName=$(echo "$target" | egrep -o "/.sh/(.*?)")

		# If the symbolic link's home directory doesn't match our HOME, change it
		if [[ "$linkHome" != "$HOME" ]] ; then
			ln -snf "$HOME$baseName" $filename
		fi
	fi
done;
