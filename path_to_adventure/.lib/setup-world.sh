#!/bin/bash

###############################################################################
##                                                                           ##
##                           SETUP FUNCTIONS                                 ##
##                                                                           ##
###############################################################################
## These have been moved into the rooms themselves

###############################################################################
##                                                                           ##
##                          TEARDOWN FUNCTIONS                               ##
##                                                                           ##
###############################################################################
function cleanup {
  # Fix permissions on LIBRARY
  local CASTLE=$WORLD/castle
  local LIBRARY=$CASTLE/library
  sudo chmod u+rwx $LIBRARY
  # Remove link from root of directory
  [[ -L ${WORLD} ]] && sudo unlink ${WORLD}
}
trap cleanup EXIT HUP QUIT TERM