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

... Or just generate it more simply, since `apt-clone` is kind of tricky to actually use, like so:

```bash
apt list --installed 2>/dev/null | sed 's/\/.*//g > packages'
```

### macOS/Homebrew:

1. Install [Homebrew Bundle][homebrew-bundle] (Should happen on first attempt to run `brew bundle`)
2. Generate the package state via `brew bundle dump --force --describe --file=/path/Brewfile.hostname.os`


## Restoring from the lists

Again, the procedures are dependent on the OS.

### Ubuntu/apt:

Use one of two ways...

1. _Attempt_ to restore the packages through [`apt-clone restore`][apt-clone] (this likely won't work across multiple different distro versions)
    - `sudo apt-clone restore FILE_NAME_HERE`
2. _Or_ restore "cleverly" via a simple new-line-delimited list of package names
    ```bash
	# Filter packages for those available
	while read package; do apt show "$package" 2>/dev/null | grep -qvz 'State:.*(virtual)' && echo "$package" >>packages-valid && echo -ne "\r\033[K$package"; done <packages

	# Install the available packages all at once
	sudo apt install $(tr '\n' ' ' <packages-valid)
    ```

### macOS/Homebrew:

1. Restore via `brew bundle install --file=/path/Brewfile.hostname.os`
2. Go make some coffee...



 [apt-clone]: https://github.com/mvo5/apt-clone
 [homebrew-bundle]: https://github.com/Homebrew/homebrew-bundle
