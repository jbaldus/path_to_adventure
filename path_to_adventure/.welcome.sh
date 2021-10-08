#!/bin/bash

source ~/.bashrc

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export PATH=$DIR:$PATH

export BOLD=$'\e[1;31m'
export RESET=$'\e[0m'


function welcome_message() {
cat << EOF
#####################################
##                                 ##
##  WELCOME TO PATH TO ADVENTURE!  ##
##                                 ##
#####################################

You are a brave adventurer indeed to embark on this adventure exploring
the world of Bash and the command line.  You will use all of the skills 
you have learned to get around in the Linux terminal.  You will need to
move to new directories, show the content of files on the terminal, and
muck about with file permissions. And much, much more!

It's dangerous to go alone, so let me give you some important advice:

> Nearly every place you go will have a README file. You should read it.

> Remember that ${BOLD}man${RESET} is a command that will show you how other commands 
  work. Use it like ${BOLD}man mv${RESET} to see what the ${BOLD}mv${RESET} command can do.

> If you really get stuck, you can type ${BOLD}help${RESET} to get a list of only the 
  commands that you will need for this adventure. Use ${BOLD}man${RESET} for more info
  on each specific command.

> At any point you can type ${BOLD}score${RESET} to get a rundown of your score. If you
  get 32 points, you win!

EOF

set_mode

cat << EOF

Like all the best role-playing games, you will begin your journey in a
humble cottage. Let's take you there now:

Type ${BOLD}cd cottage${RESET} and then press ${BOLD}[Enter]${RESET}

EOF
}

function help() {
cat << EOF

This is a list of commands that will be useful on your adventure:

${BOLD}ls${RESET}, ${BOLD}cd${RESET}, ${BOLD}pwd${RESET}, ${BOLD}rm${RESET}, ${BOLD}rmdir${RESET}, ${BOLD}mv${RESET}, ${BOLD}grep${RESET}, ${BOLD}wc${RESET}, ${BOLD}chmod${RESET}, ${BOLD}touch${RESET}, ${BOLD}echo${RESET}, ${BOLD}vim${RESET}

If you really need extra help, you can type ${BOLD}omg-help${RESET} to get a 
quick description of each of these commands.

EOF

if [ $HARDMODE -eq 1 ]; then
    echo "It seems like you are in HARD MODE, you can go back to easy mode with ${BOLD}wah-wah${RESET}."
fi
}

function omg-help() {
cat << EOF

These are the commands that might be helpful for you on this adventure. 
You will also want to use the common flags you learned for some of these 
commands:

${BOLD}ls${RESET}    -> list the files in the current directory
${BOLD}cd${RESET}    -> change to a different directory
${BOLD}pwd${RESET}   -> print what directory you're in
${BOLD}rm${RESET}    -> delete a file
${BOLD}rmdir${RESET} -> delete a directory
${BOLD}mv${RESET}    -> move a file ALSO rename a file
${BOLD}grep${RESET}  -> searches for a string of characters in a text file
${BOLD}wc${RESET}    -> counts the words in its input
${BOLD}chmod${RESET} -> changes the permissions on files and directories
${BOLD}touch${RESET} -> updates the last time of modification on a file ALSO will 
         create the file if it didn't exist
${BOLD}echo${RESET}  -> prints its argument to the terminal. Userful with file redirection
${BOLD}vim${RESET}   -> text editor for pros. We know ${BOLD}i${RESET}, ${BOLD}<ESC>${RESET}, and ${BOLD}:wq${RESET} - just the basics.

EOF

}

function set_mode() {
    echo ""
    echo "Are you up for a challenge?"
    echo "Do you want to try this in HARD MODE?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) set_hard_mode; break;;
            No ) break;;
        esac
    done
}

function set_hard_mode() {
    export PREVIOUS_PS1=$PS1
    export PS1="\\$ "
    export HARDMODE=1
    cat << EOF

Okay. I set it to hard mode for you. Your prompt won't give you any help.
If you can't handle it, just type ${BOLD}wah-wah${RESET}, and I'll give
you your old prompt back. Good Luck!

EOF
}

function wah-wah() {
    export PS1=$PREVIOUS_PS1
    export HARDMODE=0
    cat << EOF

Couldn't handle it, eh? That's okay. Get some more practice with the prompt
there to help you out, and then come back and try hard mode again!

EOF
}

welcome_message