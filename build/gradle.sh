#!/bin/bash

set -e

check_command java

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

export_path "/usr/local/gradle-${GRADLE_VERSION}/bin"

gradle --version
