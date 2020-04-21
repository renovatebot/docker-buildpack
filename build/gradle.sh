#!/bin/bash

set -e

check_command java

echo "Installing gradle $GRADLE_VERSION"

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

echo PATH="/usr/local/gradle-${GRADLE_VERSION}/bin:\$PATH" >> /usr/local/docker/env

refreshenv
link_wrapper gradle

gradle --version
