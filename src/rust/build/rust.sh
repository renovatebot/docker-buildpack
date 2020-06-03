#!/bin/bash

set -e

su -c 'curl -sSL https://sh.rustup.rs | sh -s - --no-modify-path --profile minimal --default-toolchain ${RUST_VERSION} -y' ubuntu

export_env RUST_BACKTRACE 1
export_path "/home/ubuntu/.cargo/bin"

su -c 'rustup --version' ubuntu
su -c 'cargo --version' ubuntu
su -c 'rustc --version' ubuntu
