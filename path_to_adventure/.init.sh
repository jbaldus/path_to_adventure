#!/bin/bash

source ~/.bashrc

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Add a link to the root directory to make it easier to find.
sudo ln -sf $DIR/world /World
export WORLD=/World

export PATH=$DIR:$PATH

export BOLD=$'\e[1;31m'
export RESET=$'\e[0m'

export HARDMODE=0

export NORMALMODE_PROMPT='\[\e[01;32m\]\u@\h\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\] \[\e[01;33m\]\$\[\e[0m\] '
export HARDMODE_PROMPT='${RESET}[P2A] \[\e[01;33m\]\$\[\e[0m\] '

export PS1=$NORMALMODE_PROMPT

function auto_readme {
  if [[ "$(history 1 | cut -d' ' -f4 | head -n1)" == "cd" ]]; then
    if [[ -e ./README ]]; then
      cat ./README
    fi
  fi
}

export PROMPT_COMMAND='[[ $HARDMODE -eq 0 ]] && [[ $AUTOREADME -eq 1 ]] && auto_readme'



source .setup-world.sh
source .help.sh
source .gamemode.sh
source .welcome.sh

########################
##   START THE GAME   ##
########################

setup_all
cd "$WORLD"
welcome_message