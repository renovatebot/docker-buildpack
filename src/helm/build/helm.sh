#!/bin/bash

set -e

check_semver ${HELM_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${HELM_VERSION}
  exit 1
fi

if [[ -d "/usr/local/helm/${HELM_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

mkdir -p /usr/local/helm/${HELM_VERSION}
curl -sSL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz --output helm.tgz
tar --strip 1 -C /usr/local/helm/${HELM_VERSION} -xzf helm.tgz
rm helm.tgz

export_path "/usr/local/helm/${HELM_VERSION}"

helm version
