#!/bin/bash

. /usr/local/build/util.sh

TOOLNAME=${1^^}
TOOL="/usr/local/build/${1}.sh"
shift;

if [ ! -f "$TOOL" ]; then
  echo "No tool defined - skipping"
  echo $TOOL
  exit 1;
fi

VERSION=${1}
shift;

ENVNAME=${TOOLNAME}_VERSION

if [ -z ${!ENVNAME+x} ]; then
  export $ENVNAME=$VERSION
fi

refreshenv

$TOOL $@
