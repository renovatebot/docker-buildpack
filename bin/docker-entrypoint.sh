#!/bin/bash

if [[ -f /usr/local/etc/env ]]; then
  . /usr/local/etc/env
fi

exec dumb-init -- $@
