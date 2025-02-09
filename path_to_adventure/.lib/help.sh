#!/bin/bash

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