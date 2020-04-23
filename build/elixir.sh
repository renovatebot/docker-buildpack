#!/bin/bash

set -e

check_command erl

curl -sSL https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip -o elixir.zip
mkdir -p /usr/local/elixir/
unzip elixir.zip -d /usr/local/elixir/
rm elixir.zip

export_path "/usr/local/elixir/bin"

elixir --version
mix --version

su -c 'mix local.hex --force' ubuntu
su -c 'mix local.rebar --force' ubuntu
