# Avoid duplicate inclusion
if [[ -n "${__pta_utils_imported:-}" ]]; then
    return 0
fi
__pta_utils_imported="defined"


# Some utility functions

# Set PTA_DEBUG_OUTPUT once, during load
if [[ "x${PTA_DEBUG}" == "x" ]]; then
    PTA_DEBUG_OUTPUT=/dev/null
else
    PTA_DEBUG_OUTPUT=${PTA_DEBUG_OUTPUT:-$DIR/debug.log}
fi

function dbg {
    echo $@ >>$PTA_DEBUG_OUTPUT
}


# Load each phase's scripts
function __pta_load_phase { # phase: score|setup|preexec
    local phase="$1"
    local script
    dbg "Loading scripts for phase: ${phase}"
    for script in $(find -H "$RESOURCES" -name "*${phase}.sh" -printf '%f\t%p\n' | sort | cut -f2-); do
        source "$script"
        dbg "Script ${script} loaded"
    done
}


# This function checks the score now and compares it to a previous score
# It returns 0 if the score went up, and 1 if it didn't
__pta_score-up() {
    local prev_points
    local now_points
    if [[ ! -e $RESOURCES/prev_points ]]; then
        echo 0 > $RESOURCES/prev_points
        prev_points=0
    else
        prev_points=$(cat $RESOURCES/prev_points)
    fi
    now_points=$(score -q)
    if [[ $now_points -gt $prev_points ]] ; then
        echo $now_points > $RESOURCES/prev_points
        return 0
    else
        return 1
    fi
}

#This will print the score with a red background if it went up 
# on the last command
__pta_style-score() {
    if __pta_score-up; then
        printf "${BOLD}${INVERT}Score: %2d\e[m" $(score -q)
    else
        printf "${RESET}Score: %2d" $(score -q)
    fi
}

function __pta_game_over {
    touch $RESOURCES/game_over
}

function __pta_is_game_over {
    if [[ -e "$RESOURCES/game_over" ]]; then
        return 0
    fi
    return 1
}