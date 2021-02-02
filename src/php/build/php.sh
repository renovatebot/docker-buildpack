#!/bin/bash

set -e

check_semver ${PHP_VERSION}

if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${PHP_VERSION}
  exit 1
fi

VERSION_CODENAME=$(. /etc/os-release && echo ${VERSION_CODENAME})

echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu ${VERSION_CODENAME} main" | tee /etc/apt/sources.list.d/ondrej-php.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C

VERSION=${MAJOR}.${MINOR}
packages="php${VERSION}-cli php${VERSION}-mbstring php${VERSION}-curl php${VERSION}-xml"

if [ "${MAJOR}" -lt "8" ]; then
  packages="${packages} php${VERSION}-json"
fi

apt_install $packages


php -v
