#!/bin/bash

set -e

check_command java

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

export_env GRADLE_OPTS "-Dorg.gradle.parallel=true -Dorg.gradle.configureondemand=true -Dorg.gradle.daemon=false -Dorg.gradle.caching=false"

export_path "/usr/local/gradle-${GRADLE_VERSION}/bin"

gradle --version
