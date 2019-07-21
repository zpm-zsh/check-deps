#!/usr/bin/env zsh

function gen_install_msg(){
  install_message="Please install missing packages using: \`$1\`"
  if [[ "$CLICOLOR" == "1" ]]; then
    install_message="$c[cyan]Please install missing packages using: $c[red]\`$c[yellow]$1$c[red]\`"
  fi
  echo $install_message
}

function gen_zsh_msg(){
  install_message="Please install missing zsh plugins: \`$1\`"
  if [[ "$CLICOLOR" == "1" ]]; then
    install_message="$c[cyan]Please install missing zsh plugins: $c[red]\`$c[yellow]$1$c[red]\`"
  fi
  echo $install_message
}

function get_package_if_need(){
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
  if command -v pacman >/dev/null; then
    local DEPENDENCES_ARCH_MISSING=()
    for i ($DEPENDENCES_ARCH); do
      DEPENDENCES_ARCH_MISSING+=( $(get_package_if_need $i) )
    done
    if [[ ! -z "$DEPENDENCES_ARCH_MISSING" ]]; then
      gen_install_msg "sudo pacman -S $DEPENDENCES_ARCH_MISSING"
    fi
  fi
  # Debian || Ubuntu
  if command -v dpkg >/dev/null; then
    local DEPENDENCES_DEBIAN_MISSING=()
    for i ($DEPENDENCES_DEBIAN); do
      DEPENDENCES_DEBIAN_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_DEBIAN_MISSING" ]; then
      gen_install_msg "sudo apt install $DEPENDENCES_DEBIAN_MISSING"
    fi
  fi
  
  # Node.js
  if command -v npm >/dev/null; then
    local DEPENDENCES_NPM_MISSING=()
    for i ($DEPENDENCES_NPM); do
      DEPENDENCES_NPM_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_NPM_MISSING" ]; then
      gen_install_msg "npm install -g $DEPENDENCES_NPM_MISSING"
    fi
  fi
  
  # PIP
  if command -v pip >/dev/null; then
    local DEPENDENCES_PIP_MISSING=()
    for i ($DEPENDENCES_PIP); do
      DEPENDENCES_PIP_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_PIP_MISSING" ]; then
     gen_install_msg "pip install --user $DEPENDENCES_PIP_MISSING"
    fi
  fi
  
  # ZSH
  local DEPENDENCES_ZSH_MISSING=()
  for i ($DEPENDENCES_ZSH); do
    if [[ ! ":${FPATH}:" == *"$(basename $i)"* ]]; then
      DEPENDENCES_ZSH_MISSING+=( $i )
    fi
  done
  if [ ! -z "$DEPENDENCES_ZSH_MISSING" ]; then
    gen_zsh_msg "$DEPENDENCES_ZSH_MISSING"
  fi
}

function _check_deps(){
  Check-Deps
  precmd_functions=(${precmd_functions#_check_deps})
}

if [[ "$CHECK_DEPS_AT_START" != "false" ]]; then
  precmd_functions+=( _check_deps )
fi
