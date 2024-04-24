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
    export PS1=$HARDMODE_PROMPT
    export HARDMODE=1
    #Switch BOLD and RESET
    export BOLD=$'\e[0m'
    export RESET=$'\e[1;31m'
    cat << EOF
${RESET}
=========================================================================

Okay. I set it to hard mode for you. Your prompt won't give you any help.
If you can't handle it, just type ${BOLD}wah-wah${RESET}, and I'll give
you your old prompt back. Good Luck!

=========================================================================

EOF
}


function wah-wah {
    export PS1=$NORMALMODE_PROMPT
    export HARDMODE=0
    export BOLD=$'\e[1;31m'
    export RESET=$'\e[0m'
    cat << EOF
${RESET}
Couldn't handle it, eh? That's okay. Get some more practice with the prompt
there to help you out, and then come back and try hard mode again!

If you really get stuck, you can type ${BOLD}help${RESET} to get a list of only the 
commands that you will need for this adventure. Use ${BOLD}man${RESET} for more info
on each specific command.

If you want to re-enable hard mode, just type ${BOLD}hardmode${RESET}.
EOF
}