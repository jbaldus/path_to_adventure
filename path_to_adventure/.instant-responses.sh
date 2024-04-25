source .bash-preexec.sh

shopt -s extdebug


##########################################################
##  PRECMD FUNCTIONS HAPPEN BEFORE THE PROMPT IS SHOWN  ##
##########################################################

function auto_readme {
    if [[ $HARDMODE -eq 0 && $AUTOREADME -eq 1 ]]; then
        LAST_COMMAND=$(HISTTIMEFORMAT= history 1 | sed -E "s/[ ]*[0-9]+[ ]*([^ ]+).*/\1/")
        if [[ "$LAST_COMMAND" == "cd" ]] 2>/dev/null; then
            if [[ -e ./README ]]; then
                cat ./README
            fi
        fi
    fi
}
precmd_functions+=(auto_readme)

did-you-just-win () { :; }
precmd_functions+=(did-you-just-win)

#################################################################
##  PREEXEC FUNCTIONS HAPPEN RIGHT BEFORE COMMAND IS EXECUTED  ##
##  ---------------------------------------------------------  ##
##  If they return non-zero, the command won't execute,        ##
##  thanks to the "shopt -s extdebug" setting above            ##
#################################################################
touch-bear () {
    if [[ "$@" == "touch bear" ]]; then
      echo "Ouch"
      return 1
    else
      return 0
    fi
}
preexec_functions+=(touch-bear)

touch-mirage () { :; }
preexec_functions+=(touch-mirage)

ruins-safety-check () { :; }
preexec_functions+=(ruins-safety-check)

