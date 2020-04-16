#!/bin/bash

set -e

if [ -z ${JAVA_VERSION+x} ]; then echo "No JAVA_VERSION defined - skipping" && exit; else echo "Installing java $JAVA_VERSION"; fi
if [ -z ${GRADLE_VERSION+x} ]; then echo "No GRADLE_VERSION defined - skipping" && exit; else echo "Installing gradle $GRADLE_VERSION"; fi

apt-get update 
apt-get install -y openjdk-${JAVA_VERSION}-jre-headless
rm -rf /var/lib/apt/lists/*

java -version

mkdir /opt/gradle
curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip
unzip -d /opt/gradle gradle.zip && \
rm /tmp/gradle.zip

gradle --version
