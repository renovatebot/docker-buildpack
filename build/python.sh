#!/bin/bash

set -e

check_semver ${PYTHON_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" ]]; then
  echo Invalid version: ${PYTHON_VERSION}
  exit 1
fi

apt_install python3-distutils python3-venv python${PYTHON_VERSION}-venv

export_path "\$HOME/.local/bin"
