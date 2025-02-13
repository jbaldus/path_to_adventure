# Avoid duplicate inclusion
if [[ -n "${__pta_castle_setup_imported:-}" ]]; then
    return 0
fi
__pta_castle_setup_imported="defined"


function setup_catacombs {
    local CASTLE=$WORLD/castle
    local LIBRARY=$CASTLE/library
    local CATACOMBS=$LIBRARY/catacombs

    if [[ -z $CATACOMBS ]]; then
        echo "SETUP FAILURE!!!! CATACOMBS NOT DEFINED!!! THIS SHOULDN'T HAPPEN!!!"
        return
    fi
    rm -rf $CATACOMBS/*
    local answer=$(grep Mimir $LIBRARY/*txt* | wc -l)

    for i in {1..415}; do
        mkdir -p $CATACOMBS/$i
        echo "This is a false treasure" > $CATACOMBS/$i/treasure_$i
    done

    if [ $answer -ge 1 ] && [ $answer -le 415 ]; then
        cat << EOF > $CATACOMBS/$answer/treasure_$answer
Here is your treasure:
  QUOTE: "Selfies are a lot sadder if you think of them as Alone-ies" 
  SOURCE: Uninspirational
EOF
    else
        echo "SETUP FAILURE!!!! THIS SHOULDN'T HAPPEN!!!"
        echo "Answer $answer, is apparently not between 1 and 415"
    fi
}
setup_catacombs


function setup_library {
    local CASTLE=$WORLD/castle
    local LIBRARY=$CASTLE/library

    chmod u-rwx $LIBRARY
}
setup_library