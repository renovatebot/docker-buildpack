#!/bin/bash

. /usr/local/build/util.sh

TOOL="/usr/local/build/${1}.sh"
shift;

refreshenv

if [ -f "$TOOL" ]; then
  $TOOL $@
else
   echo "No tool defined - skipping"
   echo $TOOL
   exit;
fi
