#!/bin/bash

set -e

check_semver $JAVA_VERSION

apt-get update
apt-get install -y openjdk-${BASH_REMATCH[1]}-jdk-headless
rm -rf /var/lib/apt/lists/*

java -version
