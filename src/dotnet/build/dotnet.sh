#!/bin/bash

set -e

apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu60 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

curl -sSL https://dot.net/v1/dotnet-install.sh > dotnet-install.sh

bash dotnet-install.sh

dotnet help