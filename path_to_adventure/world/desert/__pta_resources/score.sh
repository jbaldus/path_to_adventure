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
# DESERT SCORING SCRIPTS
# 
# =============================================================================

# Avoid duplicate inclusion
if [[ -n "${__pta_desert_score_imported:-}" ]]; then
    return 0
fi
__pta_desert_score_imported="defined"


# EXPORTS
export DESERT=$WORLD/desert

# ITEMS
ITEMS[desert]=0

# POSSIBLE_POINTS
POSSIBLE_POINTS[desert]=4

# SCORING_FUNCTIONS
function check_wateringholes {
    # TODO: It would be great if there was a way to randomize what the
    #       right answer is to this.
    local wateringhole_dates=( "19 May 2001" 
                               "26 Sep 2019" 
                               "02 Oct 2019"                              
                               "12 Mar 2015" 
                               "17 Jul 2017" 
                               "13 May 1987" 
                               "22 Nov 2001" 
                               "11 Apr 2008" 
                               "03 Apr 2005" 
                               "27 Sep 1995" )
    export failed_wateringhole=0
    local success=0
    local answer=5
    for i in {0..9}; do
        local date=$(date -r $DESERT/wateringhole_$i "+%d %h %Y" 2>/dev/null)
        if [[ $i -eq $answer ]]; then
            if [[ "$date" == "$(date '+%d %h %Y')" ]]; then
                success=1
            fi
            continue
        fi
        if [[ "$date" != "${wateringhole_dates[$i]}" ]]; then
            #Break the loop and set game over variable
            export failed_wateringhole=1
            touch $RESOURCES/failed_wateringhole
            __pta_game_over
            break
        fi
    done
    # Get points if $success, but not $failed
    if [[ $success -eq 1 && $failed_wateringhole -eq 0 ]]; then
        return 0
    fi
    return 1
}

function score_desert {
    if check_wateringholes; then
        ITEMS[desert]=4
    fi   
}
SCORING_FUNCTIONS+=(score_desert)

# PRINTING_FUNCTIONS: Print point summaries 
#   - just use the generic function
PRINTING_FUNCTIONS[desert]=generic_print_function


# GAME OVER Functions: PRINT MESSAGE AND GAME_OVER
function print_wrong_wateringhole {
    cat >&2 << EOF
    
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You wasted precious time touching watering holes that
only SEEMED to be there. You died of thirst, and the husk
of your body was devoured by the desert.

                        ${BOLD}GAME OVER${RESET}

Type ${BOLD}exit${RESET} and press ${BOLD}[Enter]${RESET}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
EOF
}