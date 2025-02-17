#!/bin/bash

source ~/.bashrc

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Add a link to the root directory to make it easier to find.
sudo ln -sf $DIR/world /World
export WORLD=/World

export PATH=$DIR:$PATH

export BOLD=$'\e[1;31m'
export EMPHASIS=$'\e[3;1;33m'
export INVERT=$'\e[7m'
export RESET=$'\e[0m'

export HARDMODE=0

# PROMPT_SCORE moves the cursor all the way to the right, and then back 8 
#  spaces and prints "Score: <score>". Then the "\n" prints a newline 
# If we want the score to be on the right side of the SAME line as the 
#  player types their commands, replace the "\n" with "\[\e[600D\]".
export PROMPT_SCORE='\[\e[600C\e[8D\]$(__pta_style-score)\n'
export NORMALMODE_PROMPT=$PROMPT_SCORE'\[\e[01;32m\]\u\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\] \[\e[01;33m\]\$\[\e[0m\] '
export HARDMODE_PROMPT=$PROMPT_SCORE'${RESET}[P2A] \[\e[1;33m\]\$\[\e[0m\] '

export PS1=$NORMALMODE_PROMPT


source .lib/utils.sh
source .lib/gather-resources.sh
source .lib/setup-world.sh
source .lib/help.sh
source .lib/gamemode.sh
source .lib/welcome.sh
source .lib/instant-responses.sh

########################
##   START THE GAME   ##
########################

setup_all
cd "$WORLD"
welcome_message
