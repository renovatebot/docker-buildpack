#--------------------------------------
# Target image to build
#--------------------------------------
ARG IMAGE=latest

#--------------------------------------
# Ubuntu base image to use
#--------------------------------------
ARG FLAVOR=latest

#--------------------------------------
# renovate rebuild trigger
#--------------------------------------
FROM renovate/ubuntu:18.04@sha256:bfefa9d90e8df66278ed6745efcf259bd04df21239c10e78baa191d6930d026f

#--------------------------------------
# Image: base
#--------------------------------------
FROM renovate/ubuntu:${FLAVOR} as base

ARG BUILDPACK_VERSION
LABEL org.opencontainers.image.source="https://github.com/renovatebot/docker-buildpack" \
      org.opencontainers.image.version="${BUILDPACK_VERSION}"

USER root

# Zombie killer: https://github.com/Yelp/dumb-init#readme
RUN apt-get update && \
    apt-get install -y dumb-init && \
    rm -rf /var/lib/apt/lists/*

# loading env
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

ENTRYPOINT [ "docker-entrypoint.sh" ]

COPY src/base/ /usr/local/


#--------------------------------------
# Image: erlang
#--------------------------------------
FROM base as erlang

COPY src/erlang/ /usr/local/


#--------------------------------------
# Image: golang
#--------------------------------------
FROM base as golang

COPY src/golang/ /usr/local/


#--------------------------------------
# Image: java
#--------------------------------------
FROM base as java

COPY src/java/ /usr/local/


#--------------------------------------
# Image: node
#--------------------------------------
FROM base as node

COPY src/node/ /usr/local/


#--------------------------------------
# Image: php
#--------------------------------------
FROM base as php

COPY src/php/ /usr/local/


#--------------------------------------
# Image: python
#--------------------------------------
FROM base as python

COPY src/python/ /usr/local/


#--------------------------------------
# Image: ruby
#--------------------------------------
FROM base as ruby

COPY src/ruby/ /usr/local/


#--------------------------------------
# Image: rust
#--------------------------------------
FROM base as rust

COPY src/rust/ /usr/local/


#--------------------------------------
# Image: full (latest)
#--------------------------------------
FROM base as latest

COPY src/docker/ /usr/local/
COPY src/erlang/ /usr/local/
COPY src/golang/ /usr/local/
COPY src/java/ /usr/local/
COPY src/node/ /usr/local/
COPY src/php/ /usr/local/
COPY src/python/ /usr/local/
COPY src/ruby/ /usr/local/
COPY src/rust/ /usr/local/


#--------------------------------------
# Image: final
#--------------------------------------
FROM ${IMAGE} as final
