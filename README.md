# Helper for zsh plugins, which check dependencies

This plugin will inform the user if some dependencies missing and show instruction for installation.

Now is supported:
* Debian, Ubuntu and other deb based
* Arch and derivatives
* Nodejs
* Zsh plugins (if you use [zpm](https://github.com/zpm-zsh/zpm))

### How to use from plugins

Ad to your plugin some of these instructions

```sh
# For package managers append to these arrays another item: 
# binary_file@package_for_instalation
# or one element if the name of binary file equal to the package name
DEPENDENCES_ARCH+=( node@nodejs ) 
DEPENDENCES_DEBIAN+=( node@nodejs )
DEPENDENCES_NPM+=( cli-md )

# For ZSH add name of required plugin
DEPENDENCES_ZSH+=( zsh-completions )
```


## Installation

### Using [zpm](https://github.com/zpm-zsh/zpm)

Add `zpm load zpm-zsh/check-deps` into `.zshrc`

### Using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

Execute `git clone https://github.com/zpm-zsh/check-deps ~/.oh-my-zsh/custom/plugins/check-deps`. Add `check-deps` into plugins array in `.zshrc`

### Using [antigen](https://github.com/zsh-users/antigen)

Add `antigen bundle zpm-zsh/check-deps` into `.zshrc`

### Using [zgen](https://github.com/tarjoilija/zgen)

Add `zgen load zpm-zsh/check-deps` into `.zshrc`

### TODO:


* Add Python 2 and 3
* Add other Zsh package managers

