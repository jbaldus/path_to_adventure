##########################################################
##  PRECMD FUNCTIONS HAPPEN BEFORE THE PROMPT IS SHOWN  ##
##########################################################
function bear-in-chest {
    if [[ -e "/World/cottage/treasure_chest/bear" ]]; then
        score
    fi 
}    
precmd_functions+=(bear-in-chest)

#################################################################
##  PREEXEC FUNCTIONS HAPPEN RIGHT BEFORE COMMAND IS EXECUTED  ##
##  ---------------------------------------------------------  ##
##  If they return non-zero, the command won't execute,        ##
##  thanks to the "shopt -s extdebug" setting in the script    ##
##  that sources this one                                      ##
#################################################################
function touch-bear {
    if [[ "$@" == "touch bear" ]]; then
      echo "Ouch"
      return 1
    else
      return 0
    fi
}
preexec_functions+=(touch-bear)

