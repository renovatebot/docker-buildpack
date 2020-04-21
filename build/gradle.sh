#!/bin/bash

set -e

if ! [ -z ${1+x} ]; then export GRADLE_VERSION=${1}; fi

if [ -z ${GRADLE_VERSION+x} ]; then echo "No GRADLE_VERSION defined - skipping" && exit; fi

if ! [ -x "$(command -v java)" ]; then
  echo "No java found - abborting"
  exit 1
fi

echo "Installing gradle $GRADLE_VERSION"

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

refreshenv
link_wrapper gradle

gradle --version
