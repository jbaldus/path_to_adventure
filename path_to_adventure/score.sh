#!/usr/bin/bash

TOTAL=0

function score_cave() {
    if [ -f ./cottage/treasure_chest/treasure_cave ]; then
        if [ ! -d ./cottage/leave_home/forest/cave ]; then
            echo "CAVE Points: 2"
            CAVE_POINTS=2
            TOTAL=$((TOTAL+CAVE_POINTS))
        else
            echo "CAVE: Unfinished"
        fi
    else
        echo "CAVE: Unfinished"
    fi
}

function score_castle() {
    LIBRARY=./cottage/leave_home/castle/library
    if [ -r $LIBRARY ] && [ -w $LIBRARY ] && [ -x $LIBRARY ]; then
        echo "CASTLE Points: 3"
        CASTLE_POINTS=3
        TOTAL=$((TOTAL+CASTLE_POINTS))
    else
        echo "CASTLE: Unfinished"
    fi
}

function score_desert() {
    DESERT=./cottage/leave_home/desert
    CORRECT="wateringhole_5 wateringhole_9 wateringhole_0 wateringhole_6 wateringhole_8 wateringhole_7 wateringhole_3 wateringhole_4 wateringhole_1 wateringhole_2"
    pushd $DESERT >/dev/null
    if [ wateringhole_5 -nt wateringhole_2 ] &&
       [ wateringhole_2 -nt wateringhole_1 ] &&
       [ wateringhole_1 -nt wateringhole_4 ] &&
       [ wateringhole_4 -nt wateringhole_3 ] &&
       [ wateringhole_3 -nt wateringhole_7 ] &&
       [ wateringhole_7 -nt wateringhole_8 ] &&
       [ wateringhole_8 -nt wateringhole_6 ] &&
       [ wateringhole_6 -nt wateringhole_0 ] &&
       [ wateringhole_0 -nt wateringhole_9 ]; then
        echo "DESERT Points: 4"
        DESERT_POINTS=4
        TOTAL=$((TOTAL+DESERT_POINTS))
    else
        echo "DESERT: Unfinished"
    fi
    popd > /dev/null
}

function score_ruins() {
    if [ -e ./cottage/treasure_chest/.treasure_ruins ] && [ ! $(ls ./cottage/leave_home/desert/ruins/*skeleton* 2>/dev/null) ]; then
        echo "RUINS Points: 3"
        RUINS_POINTS=3
        TOTAL=$((TOTAL+RUINS_POINTS))
    else
        echo "RUINS: Unfinished"
    fi
}

function score_forest() {
    if [ -e ./cottage/leave_home/forest/odin ]; then
        echo "FOREST BONUS! 4 Points"
        FOREST_POINTS=4
        TOTAL=$((TOTAL+FOREST_POINTS))
    fi
}

function score_glen() {
    if [ -e ./cottage/leave_home/forest/.hidden_glen/Elkimer ] && [ -e ./cottage/treasure_chest/.treasure_glen ]; then
        echo "HIDDEN GLEN Points: 8"
        GLEN_POINTS=8
        TOTAL=$((TOTAL+GLEN_POINTS))
    else
        echo "....Hmmm....Did you search everywhere?"
    fi
}

function score_library() {
    if [ -e ./cottage/treasure_chest/treasure_373 ]; then
        echo "LIBRARY Points: 6"
        LIBRARY_POINTS=6
        TOTAL=$((TOTAL+LIBRARY_POINTS))
    else
        echo "LIBRARY: Unfinished"
    fi
}

function score_cottage() {
    COTTAGE_SCORE=0
    if [ -d ./cottage/treasure_chest ]; then
        echo "Treasure Chest Created: 1 Point"
        COTTAGE_SCORE=1
    fi
    if [ -e ./cottage/name.txt ]; then
        echo "Name file created: 1 Point"
        COTTAGE_SCORE=$((COTTAGE_SCORE+1))
    fi
    if [ $COTTAGE_SCORE -lt 2 ]; then
	echo "COTTAGE: Unfinished"
    fi
    TOTAL=$((TOTAL+COTTAGE_SCORE))
}
echo "This program will tell you how you have done."
echo "============================================="
echo "How did you do for the first steps?"
score_cottage
echo ""
echo "Now, how about the rest?"
score_forest
score_castle
score_cave
score_desert
score_ruins
score_library
score_glen
echo "TOTAL SCORE: $TOTAL"
