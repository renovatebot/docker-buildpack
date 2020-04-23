#!/bin/bash

if [[ -f $BASH_ENV ]]; then
  . $BASH_ENV
fi

exec dumb-init -- $@
