#!/bin/bash

globaldir=/World

set -e
cleanup() {
    echo "Cleaning up."
    set +e
    if [ -L $globaldir ]; then
      sudo rm $globaldir
    fi
    if [ -n "$merged" ]; then
        if [ -n "$(mount | awk '$3 == merged' merged=$merged)" ]; then
            sudo umount -l $merged && sudo rm -rf $merged $workdir $upperdir
        else
            sudo rmdir $merged && sudo rm -rf $workdir $upperdir
        fi
    fi
    echo "Goodbye."
}
trap cleanup EXIT HUP INT QUIT TERM


pta="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
upperdir=$(mktemp -d)
workdir=$(mktemp -d)
merged=$(mktemp -d)
sudo mount -t overlay -o rw,lowerdir="$pta",upperdir=$upperdir,workdir=$workdir none $merged
sudo ln -sf $merged/path_to_adventure/world $globaldir

cd $merged/path_to_adventure
bash --init-file .init.sh -i

