#!/usr/bin/env zsh

if (( $+functions[zpm] )); then
  zpm zpm-zsh/colors,inline
fi

function gen_install_msg(){
  install_message="$c[cyan]Please install missing packages using: $c[red]\`$c[yellow]$1$c[red]\`$c_reset"
  echo $install_message
}

function get_package_if_need(){
  local executable
  local package
  if [[ "$1" == *@* ]]; then
    executable=${1%%@*}
    package=${1#*@}
  else
    package="$1"
    executable="$1"
  fi
  
  if (( ! $+commands[$executable] )); then
    echo $package
  fi
}

function Check-Deps(){
  #Arch System Deps
  if (( $+commands[pacman] )); then
    local DEPENDENCES_ARCH_MISSING=()
    for i ($DEPENDENCES_ARCH); do
      DEPENDENCES_ARCH_MISSING+=( $(get_package_if_need $i) )
    done
    if [[ ! -z "$DEPENDENCES_ARCH_MISSING" ]]; then
      gen_install_msg "sudo pacman -S $DEPENDENCES_ARCH_MISSING"
    fi
  fi
  
  # Debian || Ubuntu
  if (( $+commands[dpkg] )); then
    local DEPENDENCES_DEBIAN_MISSING=()
    for i ($DEPENDENCES_DEBIAN); do
      DEPENDENCES_DEBIAN_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_DEBIAN_MISSING" ]; then
      gen_install_msg "sudo apt install $DEPENDENCES_DEBIAN_MISSING"
    fi
  fi
  
  # Node.js
  if (( $+commands[npm] )); then
    local DEPENDENCES_NPM_MISSING=()
    for i ($DEPENDENCES_NPM); do
      DEPENDENCES_NPM_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_NPM_MISSING" ]; then
      gen_install_msg "npm install -g $DEPENDENCES_NPM_MISSING"
    fi
  fi
  
  # PIP
  if (( $+commands[pip] )); then
    local DEPENDENCES_PIP_MISSING=()
    for i ($DEPENDENCES_PIP); do
      DEPENDENCES_PIP_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_PIP_MISSING" ]; then
      gen_install_msg "pip install --user $DEPENDENCES_PIP_MISSING"
    fi
  fi
  
}

function _check_deps(){
  Check-Deps
  precmd_functions=(${precmd_functions#_check_deps})
}

if [[ "$CHECK_DEPS_AT_START" != "false" ]]; then
  precmd_functions+=( _check_deps )
fi
