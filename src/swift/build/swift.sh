#!/bin/bash

set -e

check_semver $SWIFT_VERSION

if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${SWIFT_VERSION}
  exit 1
fi

SWIFT_INSTALL_DIR=/usr/local/swift/${SWIFT_VERSION}

if [[ -d "${SWIFT_INSTALL_DIR}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi


apt_install \
    libatomic1 \
    libcurl4 \
    libxml2 \
    libedit2 \
    libsqlite3-0 \
    libc6-dev \
    binutils \
    libgcc-5-dev \
    libstdc++-5-dev \
    zlib1g-dev \
    libpython2.7 \
    tzdata \
    pkg-config


VERSION_ID=$(. /etc/os-release && echo ${VERSION_ID})

# https://swift.org/builds/swift-5.3-release/ubuntu1804/swift-5.3-RELEASE/swift-5.3-RELEASE-ubuntu18.04.tar.gz
if [[ "${PATCH}" = "0" ]]; then
  SWIFT_VERSION=${MAJOR}.${MINOR}
fi

SWIFT_PLATFORM=ubuntu${VERSION_ID}
SWIFT_BRANCH=swift-${SWIFT_VERSION}-release
SWIFT_VER=swift-${SWIFT_VERSION}-RELEASE
SWIFT_WEBROOT=https://swift.org/builds

SWIFT_WEBDIR="$SWIFT_WEBROOT/$SWIFT_BRANCH/$(echo $SWIFT_PLATFORM | tr -d .)"
SWIFT_BIN_URL="$SWIFT_WEBDIR/$SWIFT_VER/$SWIFT_VER-$SWIFT_PLATFORM.tar.gz"


mkdir -p $SWIFT_INSTALL_DIR

curl -fsSL $SWIFT_BIN_URL -o swift.tar.gz
tar --strip 2 -C $SWIFT_INSTALL_DIR -xzf swift.tar.gz
rm swift.tar.gz

export_path "${SWIFT_INSTALL_DIR}/bin"

swift --version
