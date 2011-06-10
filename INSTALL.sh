#! /usr/bin/env bash
#
# Script to install all of the correct symlinks (syncing 
#
#

# Check if we're running CYGWIN, otherwise this could be a very dangerous script
if [[ $OSTYPE == "cygwin" ]] ; then

	# Get the windows style home directory
	windowsStyleHome=$(cygpath -w $HOME);
 
	# First, remove all references of original files
	rm ~/.bash_profile
	rm ~/.bashrc
	rm ~/.gitconfig
	rm ~/.minttyrc
	rm -r ~/.sh
	rm -r ~/.vim
	rm ~/.vimrc
	rm -r /etc/bash_completion.d
	rm -r /usr/local/bin
	rm -r ~/vimfiles
	rm ~/_vimrc


	# Now, create symlinks
	ln -s ~/.git_box/.bash_profile ~/.bash_profile
	ln -s ~/.git_box/.bashrc ~/.bashrc
	ln -s ~/.git_box/.gitconfig ~/.gitconfig
	ln -s ~/.git_box/.minttyrc ~/.minttyrc
	ln -s ~/.git_box/.sh ~/.sh
	ln -s ~/.git_box/.vim ~/.vim
	ln -s ~/.git_box/.vimrc ~/.vimrc
	ln -s ~/.git_box/bash_completion.d /etc/bash_completion.d
	ln -s ~/.git_box/bin /usr/local/bin

	# Use cmd (windows native command prompt) to setup Windows NT Symbolic Links
	cmd /c mklink /D "$windowsStyleHome\vimfiles" "$windowsStyleHome\.git_box\.vim"
	cmd /c mklink "$windowsStyleHome\_vimrc" "$windowsStyleHome\.git_box\.vimrc"

else
	# Warn about possible danger
	echo 'This script is only meant for use on CYGWIN. It could be potentially dangerous on another OS type.';
fi
