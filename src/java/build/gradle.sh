#!/bin/bash

set -e

check_command java

curl -sL -o gradle.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip -d /usr/local gradle.zip
rm gradle.zip

export_path "/usr/local/gradle-${GRADLE_VERSION}/bin"

mkdir -p /home/ubuntu/.m2 /home/ubuntu/.gradle

cat > /home/ubuntu/.m2/settings.xml <<- EOM
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">

</settings>
EOM

cat > /home/ubuntu/.gradle/gradle.properties <<- EOM
org.gradle.parallel=true
org.gradle.configureondemand=true
org.gradle.daemon=false
org.gradle.caching=false
EOM

chown -R ubuntu /home/ubuntu/.m2 /home/ubuntu/.gradle

gradle --version
