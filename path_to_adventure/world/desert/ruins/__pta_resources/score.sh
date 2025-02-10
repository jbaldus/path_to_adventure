# This script will be sourced in the scoring script after the following
# variables have been set up:
# 
# ITEMS: an array holding the score for individual locations
# * This script should add new items for the things it cares about
# POSSIBLE_POINTS: an array holding the possible points for each location
# * Use the same key as for the ITEMS array
# SCORING_FUNCTIONS: an array holding functions to be run each time the score 
#   is determined in order to give points. 
# * This script should define its own scoring function(s) and add it(them) 
#   to the SCORING_FUNCTIONS array
# DIR: points to the directory that holds the `world` directory
# * DO NOT CHANGE THIS IN YOUR SCRIPT, OR IT WILL BREAK THE GAME!!!!
# * $DIR/score is the path to the main scoring script
# * $DIR/resources/<This module name> contains all the files in this 
#   location's __pta_resources directory when the game is running. If you need
#   to reference anything in that directory, this is how. It is also where this 
#   script will be sourced from, for whatever that's worth.
# WORLD: points to the directory that contains all the game's locations. 
# * Use it to find paths that the player can access. For example:
#   $WORLD/cottage/treasure_chest
# CHEST: points to the treasure chest directory the player creates before 
#        they can leave their cottage.
# * Use it to check to see if they have collected any treasure you might be 
#   interested in
# =============================================================================
# 
# RUINS SCORING SCRIPTS
# 
# =============================================================================

# Avoid duplicate inclusion
if [[ -n "${__pta_ruins_score_imported:-}" ]]; then
    return 0
fi
__pta_ruins_score_imported="defined"

# EXPORTS
export DESERT=$WORLD/desert
export RUINS=$DESERT/ruins

# ITEMS
ITEMS[ruins]=0

# POSSIBLE_POINTS
POSSIBLE_POINTS[ruins]=3

# SCORING_FUNCTIONS

function score_ruins {
    if [[ -e "$CHEST/.treasure_ruins" ]] && 
       [[ ! "$(ls $RUINS/*skeleton* 2>/dev/null)" ]]; then
        ITEMS[ruins]=3
    fi
}
SCORING_FUNCTIONS+=(score_ruins)

