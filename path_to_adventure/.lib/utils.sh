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