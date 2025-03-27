. $RESOURCES/World/desert/score.sh


############################################################
##  PRECMD FUNCTIONS HAPPEN BEFORE EVERY PROMPT IS SHOWN  ##
##  ----------------------------------------------------  ##
##  This means it is right *after* the previous command   ##
##  completed.
############################################################
function wrong-wateringhole {
    if [[ "$PWD" == "/World/desert" ]]; then
        check_wateringholes
    fi
    if [[ -e $RESOURCES/failed_wateringhole ]]; then
        print_wrong_wateringhole
    fi
}    
precmd_functions+=(wrong-wateringhole)

#################################################################
##  PREEXEC FUNCTIONS HAPPEN RIGHT BEFORE COMMAND IS EXECUTED  ##
##  ---------------------------------------------------------  ##
##  If they return non-zero, the command won't execute,        ##
##  thanks to the "shopt -s extdebug" setting in the script    ##
##  that sources this one                                      ##
#################################################################
function nothing { :; }
preexec_functions+=(nothing)

