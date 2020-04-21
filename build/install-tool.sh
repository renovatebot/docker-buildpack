#!/bin/bash

# . /usr/local/build/util.sh

TOOLNAME=${1^^}
TOOL="/usr/local/build/${1}.sh"
shift;

VERSION=${1}
shift;

export ${TOOLNAME}_VERSION=$VERSION

refreshenv

if [ -f "$TOOL" ]; then
  $TOOL $@
else
   echo "No tool defined - skipping"
   echo $TOOL
   exit;
fi
