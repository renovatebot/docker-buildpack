#!/bin/bash

set -e

check_semver $JAVA_VERSION

apt_install openjdk-${MAJOR}-jdk-headless

java -version
