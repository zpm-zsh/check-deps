#!/usr/bin/env zsh
function get_package_if_need(){
  if [[ "$1" == *@* ]]; then
    executable=$(echo -n $1|awk -F'@' '{print $1}')
    package=$(echo -n $1|awk -F'@' '{print $2}')
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
      echo "Please install missing packages using \`sudo pacman -S $DEPENDENCES_ARCH_MISSING\`"
    fi
  fi
  
  if (( $+commands[dpkg] )); then
    DEPENDENCES_DEBIAN_MISSING=()
    for i ($DEPENDENCES_DEBIAN); do
      DEPENDENCES_DEBIAN_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_DEBIAN_MISSING" ]; then
      echo "Please install missing packages using \`sudo apt install $DEPENDENCES_DEBIAN_MISSING\`"
    fi
  fi
  
  if (( $+commands[npm] )); then
    DEPENDENCES_NPM_MISSING=()
    for i ($DEPENDENCES_NPM); do
      DEPENDENCES_NPM_MISSING+=( $(get_package_if_need $i) )
    done
    if [ ! -z "$DEPENDENCES_NPM_MISSING" ]; then
      echo "Please install missing packages using \`sudo npm install -g $DEPENDENCES_NPM_MISSING\`"
    fi
  fi
  
  DEPENDENCES_ZSH_MISSING=()
  for i ($DEPENDENCES_ZSH); do
    if [[ ! " ${FPATH} " == *"$(basename $i)"* ]]; then
      DEPENDENCES_ZSH_MISSING+=( $i )
    fi
  done
  if [ ! -z "$DEPENDENCES_ZSH_MISSING" ]; then
    echo "Please install missing zsh plugins: \`$DEPENDENCES_ZSH_MISSING\`"
  fi
}

function _check_deps(){
  Check-Deps
  precmd_functions=(${precmd_functions#_check_deps})
}

if [[ "$CHECK_DEPS_AT_START" != "false" ]]; then
  precmd_functions+=( _check_deps )
fi
