#!/bin/bash

set -e

if [ -z ${JAVA_VERSION+x} ]; then echo "No JAVA_VERSION defined - skipping" && exit; else echo "Installing java $JAVA_VERSION"; fi

apt-get update
apt-get install -y openjdk-${JAVA_VERSION}-jre-headless
rm -rf /var/lib/apt/lists/*

java -version
