#!/bin/bash

set -e

check_semver $DOTNET_VERSION

if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${DOTNET_VERSION}
  exit 1
fi

DOTNET_INSTALL_DIR=/usr/local/dotnet/${DOTNET_VERSION}

if [[ -d "${DOTNET_INSTALL_DIR}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi


mkdir -p /usr/local/dotnet
apt_install libc6 libgcc1 libgssapi-krb5-2 libicu60 libssl1.1 libstdc++6 zlib1g

curl -sSL https://dot.net/v1/dotnet-install.sh | bash - --version $DOTNET_VERSION --install-dir ${DOTNET_INSTALL_DIR}

export_path "${DOTNET_INSTALL_DIR}"
export_env DOTNET_ROOT "${DOTNET_INSTALL_DIR}"
export_env DOTNET_CLI_TELEMETRY_OPTOUT "1"

dotnet help
