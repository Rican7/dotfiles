# Rican7's Dotfiles

Or as I like to call this, my "git box". :D

## Requirements

- [Git][git]
    - ... duh
- [Bash][bash]
    -  preferably v3 or better


## Getting Started

1. Clone this repo: `git clone git@github.com:Rican7/dotfiles.git ~/.git_box`
2. Download any submodules: `cd ~/.git_box && git submodule update --init --recursive`
3. Run the installer: `cd ~/.git_box && make`


## OS Setups

### Windows

1. Install ["Cygwin"][cygwin]... because, well, DOS/cmd sucks
2. Install ["apt-cyg"][aptcyg]
3. Using "apt-cyg", install:
    - wget
	- vim
	- there's more, but I don't remember right now. #kthxbye

### Mac OS X

1. Install ["Homebrew"][homebrew] **and** ["MacPorts"][macports], because [YOLO][port-brew-tweet].
2. [Install the GNU "coreutils"][stackoverflow-coreutils]. Seriously, [do yourself the favor][brew-coreutils-tweet].
3. ... I don't remember

### CentOS

1. Install the ["Remi"][remi] repo and get ALL THE THINGS!

 [git]: https://git-scm.com/
 [bash]: https://www.gnu.org/software/bash/
 [cygwin]: http://cygwin.com/install.html
 [aptcyg]: https://code.google.com/p/apt-cyg/
 [homebrew]: http://mxcl.github.io/homebrew/
 [macports]: http://www.macports.org/
 [port-brew-tweet]: https://twitter.com/brianleroux/status/346581119157800962
 [stackoverflow-coreutils]: http://apple.stackexchange.com/a/69332/66708
 [brew-coreutils-tweet]: https://twitter.com/trevorsuarez/status/373146388659716096
 [remi]: http://blog.famillecollet.com/pages/Config-en
