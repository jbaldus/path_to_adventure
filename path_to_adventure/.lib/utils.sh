# Some utility functions

function reverse-filepath {
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