#!/bin/bash

set -e

TARGET_TAG=${TARGET_TAG/-latest/}
TARGET_TAG=${TARGET_TAG/latest-/}
echo "TARGET_TAG=${TARGET_TAG}" >> $GITHUB_ENV

line=$(cat renovate.Dockerfile | grep "as ${IMAGE}")

if [[ ! "${line}" =~ "^FROM (.+) as ${IMAGE}$" ]]; then
  echo Not a ubuntu version - aborting: ${line}
  exit 1
fi

echo "BASE_VERSION=${${BASH_REMATCH[1]}}" >> $GITHUB_ENV
