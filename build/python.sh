#!/bin/bash

set -e

check_semver ${PYTHON_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${PYTHON_VERSION}
  exit 1
fi

apt_install python${PYTHON_VERSION}

ln -sf /usr/bin/python${MAJOR}.${MINOR} /usr/bin/python${MAJOR}
ln -sf /usr/bin/python${MAJOR}.${MINOR} /usr/bin/python
