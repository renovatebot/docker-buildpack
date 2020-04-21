#!/bin/bash

set -e

check_version GOLANG_VERSION
check_command java

echo "Installing gradle $GRADLE_VERSION"

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

refreshenv
link_wrapper gradle

gradle --version
