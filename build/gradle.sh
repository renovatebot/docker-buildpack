#!/bin/bash

set -e

if [ -z ${GRADLE_VERSION+x} ]; then echo "No GRADLE_VERSION defined - skipping" && exit; fi

if [ -z ${JAVA_VERSION+x} ]; then
  export JAVA_VERSION=8
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  . $DIR/java.sh
fi

echo "Installing gradle $GRADLE_VERSION"

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

ln -sf /usr/local/gradle-$GRADLE_VERSION/bin/gradle /usr/local/bin/

gradle --version
