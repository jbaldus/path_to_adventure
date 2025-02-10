source .lib/utils.sh

function dbg {
    echo $@ >/dev/null
}

# This script will gather all the `__pta_resources` directories here in $DIR 
# under a directory called `resources`. The `__pta_resources` directories will 
# be renamed to their parent directories, so, for example, the 
# `$WORLD/forest/cave/__pta_resources` directory will be moved 
# to `$DIR/resources/World/forest/cave`.

mkdir -p "$DIR/resources"
export RESOURCES="$DIR/resources"

function move_resources {
    local RESOURCE_DIR
    for RESOURCE_DIR in $(sudo find -H $WORLD -type d -name __pta_resources 2>/dev/null); do
        local DEST_DIR="${RESOURCES}$(dirname "$RESOURCE_DIR")"
        dbg "$RESOURCE_DIR will be moved to $DEST_DIR"
        mkdir -p "$(dirname "$DEST_DIR")"
        mv "$RESOURCE_DIR" "$DEST_DIR"
    done
}
move_resources


# It will also create a directory for all the scoring scripts 
# `$DIR/resources/scoring` and link any scripts from the `__pta_resources` 
# directories that are named *score.sh into this scoring directory. The links 
# will be named by reversing their path back to World, so 
# `/World/forest/cave/__pta_resources/score.sh` will be linked by a file named 
# `score.sh-cave-forest`, and `/World/cottage/__pta_resources/00-score.sh` will 
# be linked by a file named `00-score.sh-cottage`. This will allow for ordering 
# the scoring scripts by naming them with numbers. These scripts will be sourced 
# by the `score` command, in that order.

export SCORE_DIR=$RESOURCES/scoring
mkdir -p "$SCORE_DIR"

function gather_scoring_scripts {
    local SCRIPT
    for SCRIPT in $(find -H $RESOURCES -name *score.sh); do
        local REVNAME=$(reverse-filepath "$SCRIPT")
        echo "Linking $SCRIPT ==> $SCORE_DIR/$REVNAME"
        ln -s $SCRIPT $SCORE_DIR/$REVNAME
    done
}

gather_scoring_scripts