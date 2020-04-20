#!/bin/bash

DIR="/usr/local/build"

TOOL="${DIR}/${1}.sh"

if [ -f "$TOOL" ]; then
  . $TOOL
else
   echo "No tool defined - skipping"
   echo $TOOL
   exit;
fi
