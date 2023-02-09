#!/bin/bash

# TODO: for some reason, I can't get this to exit cleanly. The overlay mount creates a character device in the $workdir that I can't delete. I must investigate further.

set -e
cleanup() {
    echo "Cleaning up."
    set +e
    if [ -n "$merged" ]; then
        (sudo umount $merged && rm -rf $merged $workdir) || \
        (rmdir $merged && rm -rf $workdir)
    fi
    echo "All done"
}
trap cleanup EXIT HUP INT QUIT TERM



pta="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
upperdir=$(mktemp -d)
workdir=$(mktemp -d)
merged=$(mktemp -d)
sudo mount -t overlay -o rw,lowerdir="$pta",upperdir=$upperdir,workdir=$workdir none $merged
$merged/setup.sh
cd $merged/path_to_adventure
./start
cd "$pta"
sudo chmod -R +rwx $merged #in case library is still unwritable
sudo umount $merged
