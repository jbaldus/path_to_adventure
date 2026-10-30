#!/bin/bash





###############################################################################
##                                                                           ##
##                           WELCOME FUNCTIONS                               ##
##                                                                           ##
###############################################################################

function welcome_message {
  cat $RESOURCES/World/welcome.md
  (( HARDMODE )) && cat $RESOURCES/World/welcome-hardmode.md
  cat $RESOURCES/World/welcome-footer.md
}
