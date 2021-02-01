#!/bin/bash

set -e

check_semver ${RUST_VERSION}


if [[ ! "${MAJOR}" || ! "${MINOR}" || ! "${PATCH}" ]]; then
  echo Invalid version: ${RUST_VERSION}
  exit 1
fi

if [[ -d "/usr/local/rust/${RUST_VERSION}" ]]; then
  echo "Skipping, already installed"
  exit 0
fi

mkdir -p /usr/local/rust

curl -sSfLo rust.tar.gz https://static.rust-lang.org/dist/rust-${RUST_VERSION}-x86_64-unknown-linux-gnu.tar.gz
mkdir rust
pushd rust
tar --strip 1 -xf ../rust.tar.gz
./install.sh --prefix=/usr/local/rust/${RUST_VERSION} --components=cargo,rust-std-x86_64-unknown-linux-gnu,rustc
popd
rm rust.tar.gz
rm -rf rust

export_env RUST_BACKTRACE 1
export_env CARGO_HOME "/home/${USER_NAME}/.cargo"
export_path "\$CARGO_HOME/bin:/usr/local/rust/${RUST_VERSION}/bin"

cargo --version
rustc --version
