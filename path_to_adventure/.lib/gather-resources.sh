# Avoid duplicate inclusion
if [[ -n "${__pta_gather_resources_imported:-}" ]]; then
    return 0
fi
__pta_gather_resources_imported="defined"



source .lib/utils.sh

# This script will gather all the `__pta_resources` directories here in $DIR 
# under a directory called `resources`. The `__pta_resources` directories will 
# be renamed to their parent directories, so, for example, the 
# `$WORLD/forest/cave/__pta_resources` directory will be moved 
# to `$DIR/resources/World/forest/cave`.


export RESOURCES="$DIR/resources"
mkdir -p "$RESOURCES"

function __pta_move_resources {
    shopt -s dotglob
    local RESOURCE_DIR
    for RESOURCE_DIR in $(sudo find -H $WORLD -type d -name __pta_resources 2>/dev/null); do
        local DEST_DIR="${RESOURCES}$(dirname "$RESOURCE_DIR")"
        dbg "$RESOURCE_DIR will be moved to $DEST_DIR"
        mkdir -p "$(dirname "$DEST_DIR")"
        if [[ -d "$DEST_DIR" ]]; then
            mv "$RESOURCE_DIR"/* "$DEST_DIR/"
            rmdir "$RESOURCE_DIR"
        else
            mv "$RESOURCE_DIR" "$DEST_DIR"
        fi
    done
    shopt -u dotglob
}
__pta_move_resources


# It will also create a directory for all the scoring scripts 
# `$DIR/resources/scoring` and link any scripts from the `__pta_resources` 
# directories that are named *score.sh into this scoring directory. The links 
# will be named by reversing their path back to World, so 
# `/World/forest/cave/__pta_resources/score.sh` will be linked by a file named 
# `score.sh-cave-forest`, and `/World/cottage/__pta_resources/00-score.sh` will 
# be linked by a file named `00-score.sh-cottage`. This will allow for ordering 
# the scoring scripts by naming them with numbers. These scripts will be sourced 
# by the `score` command, in that order.

function __pta_gather { #filepattern #directory
    local filepattern="$1"
    local directory="$2"
    local thisfile
    for thisfile in $(find -H $RESOURCES -name $filepattern); do
        local revname=$(__pta_reverse-filepath "$thisfile")
        dbg "Linking $thisfile ==> $directory/$revname"
        ln -s $thisfile $directory/$revname
    done
}

export SCORE_DIR="$RESOURCES/scoring"
mkdir -p "$SCORE_DIR"

__pta_gather '*score.sh' "$SCORE_DIR"

# Similarly create directory for setup scripts:
export SETUP_DIR="$RESOURCES/setup"
mkdir -p "$SETUP_DIR"

__pta_gather '*setup.sh' "$SETUP_DIR"

# Also, for preexec scripts:
export PREEXEC_DIR="$RESOURCES/preexec"
mkdir -p "$PREEXEC_DIR"

__pta_gather '*preexec.sh' "$PREEXEC_DIR"
