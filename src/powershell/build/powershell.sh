#!/bin/bash

set -e

check_semver ${POWERSHELL_VERSION}

if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${POWERSHELL_VERSION}
  exit 1
fi

if [[ -d "/usr/local/powershell/${POWERSHELL_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

VERSION_CODENAME=$(. /etc/os-release && echo ${VERSION_CODENAME}) 
  
 case "$VERSION_CODENAME" in 
   "focal") apt_install libc6 libgcc1 libgssapi-krb5-2 libicu66 libssl1.1 libstdc++6 zlib1g;; 
   "bionic") apt_install libc6 libgcc1 libgssapi-krb5-2 libicu60 libssl1.1 libstdc++6 zlib1g;; 
 esac 

mkdir -p /usr/local/powershell/${POWERSHELL_VERSION}
curl -sSL https://github.com/PowerShell/PowerShell/releases/download/v${POWERSHELL_VERSION}/powershell-${POWERSHELL_VERSION}-linux-x64.tar.gz --output powershell.tgz
tar --strip 1 -C /usr/local/powershell/${POWERSHELL_VERSION} -xzf powershell.tgz
rm powershell.tgz

export_path "/usr/local/powershell/${POWERSHELL_VERSION}"

pwsh -Version
