#!/usr/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

TOTAL=0

function score_cave() {
    if [ -f $DIR/cottage/treasure_chest/treasure_cave ] &&
       [ ! -d $DIR/cottage/outside/forest/cave ]; then
        CAVE_POINTS=2
        echo "CAVE Points: 2"
        TOTAL=$((TOTAL+CAVE_POINTS))
    else
        echo "CAVE: Unfinished"
    fi
}

function score_castle() {
    LIBRARY=$DIR/cottage/outside/castle/library
    if [ -r $LIBRARY ] && 
       [ -w $LIBRARY ] && 
       [ -x $LIBRARY ]; then
        CASTLE_POINTS=3
        echo "CASTLE Points: 3"
        TOTAL=$((TOTAL+CASTLE_POINTS))
    else
        echo "CASTLE: Unfinished"
    fi
}

function score_desert() {
    DESERT=$DIR/cottage/outside/desert
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
        DESERT_POINTS=4
        echo "DESERT Points: 4"
        TOTAL=$((TOTAL+DESERT_POINTS))
    else
        echo "DESERT: Unfinished"
    fi
    popd > /dev/null
}

function score_ruins() {
    if [ -e $DIR/cottage/treasure_chest/.treasure_ruins ] && 
       [ ! $(ls $DIR/cottage/outside/desert/ruins/*skeleton* 2>/dev/null) ]; then
        RUINS_POINTS=3
        echo "RUINS Points: 3"
        TOTAL=$((TOTAL+RUINS_POINTS))
    else
        echo "RUINS: Unfinished"
    fi
}

function score_forest() {
    if [ -e $DIR/cottage/outside/forest/odin ]; then
        FOREST_POINTS=4
        echo "FOREST BONUS! 4 Points"
        TOTAL=$((TOTAL+FOREST_POINTS))
    fi
}

function score_glen() {
    if [ -e $DIR/cottage/outside/forest/.hidden_glen/elkimer ] && 
       [ -e $DIR/cottage/treasure_chest/.treasure_glen ]; then
        GLEN_POINTS=8
        echo "HIDDEN GLEN Points: 8"
        TOTAL=$((TOTAL+GLEN_POINTS))
    else
        echo "....Hmmm....Did you search everywhere?"
    fi
}

function score_library() {
    if [ -e $DIR/cottage/treasure_chest/treasure_373 ]; then
        LIBRARY_POINTS=6
        echo "LIBRARY Points: 6"
        TOTAL=$((TOTAL+LIBRARY_POINTS))
    else
        echo "LIBRARY: Unfinished"
    fi
}

function score_cottage() {
    COTTAGE_SCORE=0
    if [ -d $DIR/cottage/treasure_chest ]; then
        COTTAGE_SCORE=$((COTTAGE_SCORE+1))
        echo "Treasure Chest Created: 1 Point"
    fi
    if [ -e $DIR/cottage/name.txt ]; then
        echo "Name file created: 1 Point"
        COTTAGE_SCORE=$((COTTAGE_SCORE+1))
    fi
    if [ $COTTAGE_SCORE -lt 2 ]; then
	echo "COTTAGE: Unfinished"
    fi
    TOTAL=$((TOTAL+COTTAGE_SCORE))
}

function bear_in_treasure_chest() {
    if [ -e $DIR/cottage/treasure_chest/bear ]; then
        echo "You've put a bear in your treasure chest!"
        echo "It eats all your points: -$TOTAL Points!"
        TOTAL=0
    fi
}

echo "This program will tell you how you have done."
echo "============================================="
echo "How did you do for the first steps?"
score_cottage
echo ""
echo "Now, how about the rest?"
echo "========================"
score_forest
score_castle
score_cave
score_desert
score_ruins
score_library
score_glen
bear_in_treasure_chest
echo "==================="
echo "TOTAL SCORE: $TOTAL"
