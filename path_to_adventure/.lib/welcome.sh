#!/bin/bash





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

> Remember that ${EMPHASIS}man${RESET} is a command that will show you how other commands 
  work. Use it like ${EMPHASIS}man mv${RESET} to see what the ${BOLD}mv${RESET} command can do.

EOF
if [ $HARDMODE -eq 0 ]; then
cat << EOF
> If you really get stuck, you can type ${EMPHASIS}help${RESET} to get a list of only the 
  commands that you will need for this adventure. Use ${BOEMPHASISD}man${RESET} for more info
  on each specific command.

EOF
fi

cat << EOF
> At any point you can type ${EMPHASIS}score${RESET} to get a rundown of your score. If you
  get 32 points, you win!

Like all the best role-playing games, you will begin your journey in a
humble cottage. Let's take you there now:

Type ${EMPHASIS}cd cottage${RESET} and then press ${EMPHASIS}[Enter]${RESET}

EOF
}
