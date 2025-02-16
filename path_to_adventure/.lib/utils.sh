# Avoid duplicate inclusion
if [[ -n "${__pta_utils_imported:-}" ]]; then
    return 0
fi
__pta_utils_imported="defined"


# Some utility functions

function dbg {
    echo $@ >/dev/null
}

function __pta_reverse-filepath {
    if [[ $# -ne 1 ]]; then
        return
    fi
    local FILEPATH="$1"
    local -a CHUNKS
    while [[ "$FILEPATH" != "/" 
          && "$FILEPATH" != "."
          && "$(basename $FILEPATH)" != "World" ]]; do
        CHUNKS+=("$(basename $FILEPATH)")
        FILEPATH="$(dirname $FILEPATH)"
    done
    local REVERSED="${CHUNKS[*]}"
    echo ${REVERSED// /-}
}


# This function will source all the files in a directory
function __pta_load_all { #directory
    local script_dir="$1"
    local script
    for script in "$script_dir"/*; do
        if [[ -e "$script" ]]; then 
            source "$script"
        fi
    done

}


# This function checks the score now and compares it to a previous score
# It returns 0 if the score went up, and 1 if it didn't
__pta_score-up() {
    local prev_points
    local now_points
    if [[ ! -e $DIR/resources/prev_points ]]; then
        echo 0 > $DIR/resources/prev_points
        prev_points=0
    else
        prev_points=$(cat $DIR/resources/prev_points)
    fi
    now_points=$(score -q)
    if [[ $now_points -gt $prev_points ]] ; then
        echo $now_points > $DIR/resources/prev_points
        return 0
    else
        return 1
    fi
}


#This will print the score with a red background if it went up 
# on the last command
__pta_style-score() {
    if __pta_score-up; then
        printf "${BOLD}${INVERT}Score: %2d${RESET}" $(score -q)
    else
        printf "${RESET}Score: %2d" $(score -q)
    fi

}