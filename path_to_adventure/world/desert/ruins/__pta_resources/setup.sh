
# Avoid duplicate inclusion
if [[ -n "${__pta_ruins_setup_imported:-}" ]]; then
    return 0
fi
__pta_ruins_setup_imported="defined"


function setup_skeletons {
    local DESERT=$WORLD/desert
    local RUINS=$DESERT/ruins
    local skeleton_sayings=(  "Rattle me BONES, I'm a skeleton!"
                              "Listen to me play a xylophone solo on my RIBS!"
                              "I wish I could go to the Prom, but I have no BODY to go with. :("
                              "I'm so calm, cuz nothing gets under my SKIN"
                              "You better BONE up on your command line skills"
                              "Don't you think me and my friends are HUMERUS? (That's a name of a bone)")
  
    for i in {34..50}; do 
        echo ${skeleton_sayings[$(($i % ${#skeleton_sayings[@]}))]} > $RUINS/skeleton$i
    done
    for i in {287..299}; do 
        echo ${skeleton_sayings[$(($i % ${#skeleton_sayings[@]}))]} > $RUINS/${i}skeleton
    done
}
setup_skeletons