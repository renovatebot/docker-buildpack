#!/bin/bash

set -e

check_semver $DOTNET_VERSION

apt_install libc6 libgcc1 libgssapi-krb5-2 libicu60 libssl1.1 libstdc++6 zlib1g

curl -sSL -o /usr/local/dotnet-install.sh https://dot.net/v1/dotnet-install.sh
bash /usr/local/dotnet-install.sh --version $DOTNET_VERSION --install-dir /usr/local/dotnet-${DOTNET_VERSION}

export_path "/usr/local/dotnet-${DOTNET_VERSION}"
export_env DOTNET_ROOT "/usr/local/dotnet-${DOTNET_VERSION}"

dotnet help