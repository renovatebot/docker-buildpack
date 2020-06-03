#!/bin/bash

set -e

check_semver ${PHP_VERSION}

if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${PHP_VERSION}
  exit 1
fi


echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu bionic main" | tee /etc/apt/sources.list.d/ondrej-php.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

VERSION=${MAJOR}.${MINOR}
apt_install php${VERSION}-cli php${VERSION}-mbstring php${VERSION}-curl php${VERSION}-xml php${VERSION}-json


php -v
