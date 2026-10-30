#!/bin/bash

function help {
  if [ $HARDMODE -eq 0 ]; then 
    cat $RESOURCES/World/help.md
  else
    cat $RESOURCES/World/help-hardmode.md
  fi
}

function p2a-help {
  if [ $HARDMODE -eq 0 ]; then 
    cat $RESOURCES/World/p2a-help.md
  else
    cat $RESOURCES/World/help-hardmode.md
  fi
}