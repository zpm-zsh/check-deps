#!/usr/bin/env zsh

declare -a DEPENDENCES_ARCH
declare -a DEPENDENCES_DEBIAN
declare -a DEPENDENCES_NPM
declare -a DEPENDENCES_PIP

autoload -Uz get_package_if_need gen_install_msg check-deps 
