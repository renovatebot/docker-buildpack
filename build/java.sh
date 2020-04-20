#!/bin/bash

set -e

if ! [ -z ${1+x} ]; then export JAVA_VERSION=${1}; fi

if [ -z ${JAVA_VERSION+x} ]; then echo "No JAVA_VERSION defined - skipping" && exit; else echo "Installing java $JAVA_VERSION"; fi

SEMVER_REGEX="^(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?(\.(0|[1-9][0-9]*))?$"

if ! [[ "$JAVA_VERSION" =~ $SEMVER_REGEX ]]; then
  echo Not a semver tag - skipping: ${JAVA_VERSION}
  exit
fi

apt-get update
apt-get install -y openjdk-${BASH_REMATCH[1]}-jdk-headless
rm -rf /var/lib/apt/lists/*

java -version
