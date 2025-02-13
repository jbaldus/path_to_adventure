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
# CASTLE & LIBRARY SCORING SCRIPTS
# 
# =============================================================================

# Avoid duplicate inclusion
if [[ -n "${__pta_castle_score_imported:-}" ]]; then
    return 0
fi
__pta_castle_score_imported="defined"


# EXPORTS
export CASTLE=$WORLD/castle
export LIBRARY=$CASTLE/library

# ITEMS
ITEMS[castle]=0
ITEMS[library]=0

# POSSIBLE_POINTS
POSSIBLE_POINTS[castle]=3
POSSIBLE_POINTS[library]=6

# SCORING_FUNCTIONS

function score_castle {
    if [[ -r "$LIBRARY" ]] && 
       [[ -w "$LIBRARY" ]] && 
       [[ -x "$LIBRARY" ]]; then
       ITEMS[castle]=3
    fi
}
SCORING_FUNCTIONS+=(score_castle)


function score_library {
    if [[ ${ITEMS[castle]} -ne 0 ]]; then 
        local answer=$(grep Mimir $LIBRARY/*txt* | wc -l)
        if [[ -e "$CHEST/treasure_${answer}" ]]; then
            ITEMS[library]=6
        fi
    fi
}
SCORING_FUNCTIONS+=(score_library)


# PRINTING_FUNCTIONS: Print point summaries 
#   - just use the generic function
PRINTING_FUNCTIONS[castle]=generic_print_function
PRINTING_FUNCTIONS[library]=generic_print_function
