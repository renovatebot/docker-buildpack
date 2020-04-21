#!/bin/bash

set -e

check_command erl

curl -sSL https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip -o elixir.zip
mkdir -p /usr/local/elixir/
unzip elixir.zip -d /usr/local/elixir/
rm elixir.zip

echo PATH="/usr/local/elixir/bin:\$PATH" >> /usr/local/docker/env

refreshenv

link_wrapper elixir
link_wrapper elixirc
link_wrapper iex
link_wrapper mix


elixir --version
mix --version
