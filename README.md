# Helper for zsh plugins, which check dependencies

This plugin will inform the user if some dependencies missing and show instruction for installation.

Now is supported:
* Debian, Ubuntu and other deb based
* Arch and derivatives
* Nodejs
* Zsh plugins


### How to use from plugins

Add to your plugin some of these instructions

```sh
# For package managers append to these arrays another item: 
# binary_file@package_for_instalation
# or one element if the name of binary file equal to the package name
DEPENDENCES_ARCH+=( node@nodejs ) 
DEPENDENCES_DEBIAN+=( node@nodejs )
DEPENDENCES_NPM+=( cli-md )
```

## Installation

### This plugin depends on [zsh-helpres](https://github.com/zpm-zsh/helpers) and [zsh-colors](https://github.com/zpm-zsh/colors)

If you don't use [zpm](https://github.com/zpm-zsh/zpm), install it manually and activate it before this plugin. 
If you use zpm you don’t need to do anything

### Using [zpm](https://github.com/zpm-zsh/zpm)

Add `zpm load zpm-zsh/check-deps` into `.zshrc`

### Using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

Execute `git clone https://github.com/zpm-zsh/check-deps ~/.oh-my-zsh/custom/plugins/check-deps`. Add `check-deps` into plugins array in `.zshrc`

### Using [antigen](https://github.com/zsh-users/antigen)

Add `antigen bundle zpm-zsh/check-deps` into `.zshrc`

### Using [zgen](https://github.com/tarjoilija/zgen)

Add `zgen load zpm-zsh/check-deps` into `.zshrc`

### TODO:

- Add zsh plugins check