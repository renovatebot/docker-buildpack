#!/bin/bash

set -e

check_version JAVA_VERSION

SEMVER_REGEX="^(0|[1-9][0-9]*)(\.(0|[1-9][0-9]*))?(\.(0|[1-9][0-9]*))?$"

if ! [[ "$JAVA_VERSION" =~ $SEMVER_REGEX ]]; then
  echo Not a semver tag - skipping: ${JAVA_VERSION}
  exit
fi

apt-get update
apt-get install -y openjdk-${BASH_REMATCH[1]}-jdk-headless
rm -rf /var/lib/apt/lists/*

java -version
