
# Avoid duplicate inclusion
if [[ -n "${__pta_desert_setup_imported:-}" ]]; then
    return 0
fi
__pta_desert_setup_imported="defined"


function setup_wateringholes {
    local DESERT=$WORLD/desert
    rm $DESERT/wateringhole_*
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
    local i
    for i in {0..9}; do
        touch --date "${wateringhole_dates[$i]}" $DESERT/wateringhole_$i
    done
}

setup_wateringholes