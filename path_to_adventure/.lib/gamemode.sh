#!/bin/bash

function set_mode {
    echo ""
    echo "Are you up for a challenge?"
    echo "Do you want to try this in HARD MODE?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) hardmode; break;;
            No ) break;;
        esac
    done
}


function hardmode {
    export HARDMODE_PROMPT=$PROMPT_SCORE'\[${RESET}\][P2A] \[\e[1;33m\]\$\[\e[0m\] '
    export PS1=$HARDMODE_PROMPT
    export HARDMODE=1
    #Switch BOLD and RESET
    export BOLD=$'\e[0m'
    export RESET=$'\e[0m\e[1;31m'
    cat $RESOURCES/World/set-to-hardmode.md
}


function wah-wah {
    export PS1=$NORMALMODE_PROMPT
    export HARDMODE=0
    export BOLD=$'\e[1;31m'
    export RESET=$'\e[0m'
    cat $RESOURCES/World/abandon-hardmode.md
}