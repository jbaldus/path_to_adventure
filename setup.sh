#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PTA=$DIR/path_to_adventure
COTTAGE=$PTA/cottage
OUTSIDE=$COTTAGE/outside
FOREST=$OUTSIDE/forest
DESERT=$OUTSIDE/desert
CASTLE=$OUTSIDE/castle
LIBRARY=$CASTLE/library
CATACOMBS=$LIBRARY/catacombs
RUINS=$DESERT/ruins

# -rwxrwxrwx. 1 jason jason    0 May 19  2001 wateringhole_0
# -rwxrwxrwx. 1 jason jason    0 Sep 26  2019 wateringhole_1
# -rwxrwxrwx. 1 jason jason    0 Oct  2  2019 wateringhole_2
# -rwxrwxrwx. 1 jason jason    0 Mar 12  2015 wateringhole_3
# -rwxrwxrwx. 1 jason jason    0 Jul 17  2017 wateringhole_4
# -rwxrwxrwx. 1 jason jason    0 May 13  1987 wateringhole_5
# -rwxrwxrwx. 1 jason jason    0 Nov 22  2001 wateringhole_6
# -rwxrwxrwx. 1 jason jason    0 Apr 11  2008 wateringhole_7
# -rwxrwxrwx. 1 jason jason    0 Apr  3  2005 wateringhole_8
# -rwxrwxrwx. 1 jason jason    0 Sep 27  1995 wateringhole_9

function setup_wateringholes() {
  rm $DESERT/wateringhole_*
  local wateringhole_dates=( "19 May 2001" 
                             "26 Sep 2019" 
                             "2  Oct 2019"                              
                             "12 Mar 2015" 
                             "17 Jul 2017" 
                             "13 May 1987" 
                             "22 Nov 2001" 
                             "11 Apr 2008" 
                             "3  Apr 2005" 
                             "27 Sep 1995" )

  for i in {0..9}; do
    touch --date "${wateringhole_dates[$i]}" $DESERT/wateringhole_$i
  done
}

function setup_catacombs () {
    chmod u+rwx $LIBRARY
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
      echo Answer $answer, is apparently not between 1 and 415
    fi
    chmod u-rwx $LIBRARY
}

function setup_skeletons () {
    local skeleton_sayings=( "Rattle me BONES, I'm a skeleton!"
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

function setup_all() {
    setup_wateringholes
    setup_catacombs
    setup_skeletons
}