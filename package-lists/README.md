# Package Lists

This directory contains files that describe the packages installed on my various systems.

The intent of this is to:

- Be able to easily "sync" what packages I have installed across similar machines
- Backup the list of installed packages on a machine, in case I have to re-install the OS
- Be able to more easily "audit" changes to the packages installed on a machine


## Generating the lists

Since the various machines that I use, use different operating systems, the procedures for generating these lists is different per environment. I'll list the process per OS/env here:

### Ubuntu/apt:

1. Install [`apt-clone`][apt-clone] (Should be able to do this via `sudo apt install apt-clone`)
2. Generate the package state via `sudo apt-clone clone "$(./generate-apt-clone-name)"`

### macOS/Homebrew:

1. Install [Homebrew Bundle][homebrew-bundle] (Should happen on first attempt to run `brew bundle`)
2. Generate the package state via `brew bundle dump --force --describe --file=/path/Brewfile.hostname.os`



 [apt-clone]: https://github.com/mvo5/apt-clone
 [homebrew-bundle]: https://github.com/Homebrew/homebrew-bundle
