#!/bin/bash

. /usr/local/build/util.sh

TOOLNAME=${1}
TOOL="/usr/local/build/${1}.sh"
shift;

if [ ! -f "$TOOL" ]; then
  echo "No tool defined - skipping: ${TOOLNAME}"
  exit 1;
fi

VERSION=${1}
shift;

ENVNAME=${TOOLNAME^^}_VERSION

if [ ${VERSION} ]; then
  export $ENVNAME=$VERSION
fi

check_version ${ENVNAME}

. $TOOL $@
