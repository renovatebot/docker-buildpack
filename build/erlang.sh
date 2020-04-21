#!/bin/bash

set -e

curl -sSL https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -o erlang.deb
dpkg -i erlang.deb
rm -f erlang.deb

apt-get update
apt-cache policy esl-erlang
apt-get install -y esl-erlang=1:$ERLANG_VERSION
rm -rf /var/lib/apt/lists/*

erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().'  -noshell
