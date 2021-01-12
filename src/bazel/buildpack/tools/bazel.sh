#!/bin/bash

set -e

check_semver ${BAZELISK_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${BAZELISK_VERSION}
  exit 1
fi

if [[ -d "/usr/local/bazel/${BAZELISK_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

# bazel depends on
apt_install git diff patch

mkdir -p /usr/local/bazel/${BAZELISK_VERSION}
curl -sSL https://github.com/bazelbuild/bazelisk/releases/download/${BAZELISK_VERSION}/bazelisk-linux-amd64 --output /usr/local/bazel/${BAZELISK_VERSION}/bazelisk

export_path "/usr/local/bazelisk/${BAZELISK_VERSION}"

bazelisk version
