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

###############################################################################
##                                                                           ##
##                           SETUP FUNCTIONS                                 ##
##                                                                           ##
###############################################################################
COTTAGE=$WORLD/cottage

function setup_wateringholes {
  local DESERT=$WORLD/desert
  rm $DESERT/wateringhole_*
  local wateringhole_dates=( "19 May 2001" 
                             "26 Sep 2019" 
                             "02 Oct 2019"                              
                             "12 Mar 2015" 
                             "17 Jul 2017" 
                             "13 May 1987" 
                             "22 Nov 2001" 
                             "11 Apr 2008" 
                             "03 Apr 2005" 
                             "27 Sep 1995" )

  for i in {0..9}; do
    touch --date "${wateringhole_dates[$i]}" $DESERT/wateringhole_$i
  done
}

function setup_catacombs {
  local CASTLE=$WORLD/castle
  local LIBRARY=$CASTLE/library
  local CATACOMBS=$LIBRARY/catacombs

  chmod u+rwx $LIBRARY
  rm -rf $CATACOMBS/*
  local answer=$(grep Mimir $LIBRARY/*txt* | wc -l)

  for i in {1..415}; do
    mkdir -p $CATACOMBS/$i
    echo "This is a false treasure" > $CATACOMBS/$i/treasure_$i
  done

  if [ $answer -ge 1 ] && [ $answer -le 415 ]; then
    cat << EOF > $CATACOMBS/$answer/treasure_$answer
Here is your treasure:
  QUOTE: "Selfies are a lot sadder if you think of them as Alone-ies" 
  SOURCE: Uninspirational
EOF
  else
    echo Answer $answer, is apparently not between 1 and 415
  fi
  chmod u-rwx $LIBRARY
}

function setup_skeletons {
  local DESERT=$WORLD/desert
  local RUINS=$DESERT/ruins
  local skeleton_sayings=(  "Rattle me BONES, I'm a skeleton!"
                            "Listen to me play a xylophone solo on my RIBS!"
                            "I wish I could go to the Prom, but I have no BODY to go with. :("
                            "I'm so calm, cuz nothing gets under my SKIN"
                            "You better BONE up on your command line skills"
                            "Don't you think me and my friends are HUMERUS? (That's a name of a bone)")
  
  for i in {34..50}; do 
    echo ${skeleton_sayings[$(($i % ${#skeleton_sayings[@]}))]} > $RUINS/skeleton$i
  done
  for i in {287..299}; do 
    echo ${skeleton_sayings[$(($i % ${#skeleton_sayings[@]}))]} > $RUINS/${i}skeleton
  done
}

function setup_all {
  setup_wateringholes
  setup_catacombs
  setup_skeletons
}

###############################################################################
##                                                                           ##
##                          TEARDOWN FUNCTIONS                               ##
##                                                                           ##
###############################################################################
function cleanup {
  # Fix permissions on LIBRARY
  local CASTLE=$WORLD/castle
  local LIBRARY=$CASTLE/library
  sudo chmod u+rwx $LIBRARY
  # Remove link from root of directory
  [[ -L /World ]] && sudo rm /World
}
trap cleanup EXIT HUP INT QUIT TERM

###############################################################################
##                                                                           ##
##                           WELCOME FUNCTIONS                               ##
##                                                                           ##
###############################################################################

function welcome_message {
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

EOF

set_mode

cat << EOF

It's dangerous to go alone, so let me give you some important advice:

> Nearly every place you go will have a README file. You should read it.

> Remember that ${BOLD}man${RESET} is a command that will show you how other commands 
  work. Use it like ${BOLD}man mv${RESET} to see what the ${BOLD}mv${RESET} command can do.

EOF
if [ $HARDMODE -eq 0 ]; then
cat << EOF
> If you really get stuck, you can type ${BOLD}help${RESET} to get a list of only the 
  commands that you will need for this adventure. Use ${BOLD}man${RESET} for more info
  on each specific command.

EOF
fi

cat << EOF
> At any point you can type ${BOLD}score${RESET} to get a rundown of your score. If you
  get 32 points, you win!

Like all the best role-playing games, you will begin your journey in a
humble cottage. Let's take you there now:

Type ${BOLD}cd cottage${RESET} and then press ${BOLD}[Enter]${RESET}

EOF
}

function help {
  if [ $HARDMODE -eq 0 ]; then 
cat << EOF

This is a list of commands that will be useful on your adventure:

${BOLD}ls${RESET}, ${BOLD}cat${RESET}, ${BOLD}cd${RESET}, ${BOLD}pwd${RESET}, ${BOLD}rm${RESET}, ${BOLD}rmdir${RESET}, ${BOLD}mv${RESET}, ${BOLD}grep${RESET}, ${BOLD}wc${RESET}, ${BOLD}chmod${RESET}, ${BOLD}touch${RESET}, ${BOLD}mkdir${RESET}, ${BOLD}man${RESET}, ${BOLD}echo${RESET}, ${BOLD}vim${RESET}

If you really need extra help, you can type ${BOLD}p2a-help${RESET} to get a 
quick description of each of these commands.

EOF
else
    echo ""
    echo "It seems like you are in HARD MODE, you can go back to easy mode with ${BOLD}wah-wah${RESET}."
    echo ""
fi
}

function p2a-help {
  if [ $HARDMODE -eq 0 ]; then
cat << EOF

These are the commands that might be helpful for you on this adventure. 
You will also want to use the common flags you learned for some of these 
commands:

${BOLD}ls${RESET}    -> list the files in the current directory
${BOLD}cat${RESET}   -> print the contents of a file to the terminal
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
${BOLD}mkdir${RESET} -> create a directory
${BOLD}man${RESET}   -> show the man page (manual) for a command
${BOLD}echo${RESET}  -> prints its argument to the terminal. Userful with file redirection
${BOLD}vim${RESET}   -> text editor for pros. We know ${BOLD}i${RESET}, ${BOLD}<ESC>${RESET}, and ${BOLD}:wq${RESET} - just the basics.

EOF
else
    echo ""
    echo "It seems like you are in HARD MODE, you can go back to easy mode with ${BOLD}wah-wah${RESET}."
    echo ""
fi
}

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

setup_all
cd "$WORLD"
welcome_message