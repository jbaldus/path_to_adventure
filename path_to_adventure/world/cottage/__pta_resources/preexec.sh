############################################################
##  PRECMD FUNCTIONS HAPPEN BEFORE EVERY PROMPT IS SHOWN  ##
##  ----------------------------------------------------  ##
##  This means it is right *after* the previous command   ##
##  completed.
############################################################
function example_function {
    if [[ $__bp_last_ret_value -ne 0 ]]; then #If previous command failed
        echo -n "💔"
    fi
}    
precmd_functions+=(example_function)

#################################################################
##  PREEXEC FUNCTIONS HAPPEN RIGHT BEFORE COMMAND IS EXECUTED  ##
##  ---------------------------------------------------------  ##
##  If they return non-zero, the command won't execute,        ##
##  thanks to the "shopt -s extdebug" setting in the script    ##
##  that sources this one                                      ##
#################################################################
function appreciate {
    if [[ "$@" == "Mr. B is great" ]]; then
        echo "Shut up, baby. I know it!"
        return 1 # The command will not run
    else
        return 0 # The command will run as normal
    fi
}
preexec_functions+=(appreciate)

