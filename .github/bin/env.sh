#!/bin/bash

set -e

TARGET_TAG=${TARGET_TAG/-latest/}
TARGET_TAG=${TARGET_TAG/latest-/}
echo "TARGET_TAG=${TARGET_TAG}" | tee -a $GITHUB_ENV

line=$(cat renovate.Dockerfile | grep "as ${IMAGE}")
re="^FROM (.+?) as ${IMAGE}$"

if [[ ! "${line}" =~ $re ]]; then
  echo Not a ubuntu version - aborting: ${line}
  exit 1
fi

echo "BASE_VERSION=${BASH_REMATCH[1]}" | tee -a $GITHUB_ENV
