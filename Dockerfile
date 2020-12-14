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
FROM renovate/ubuntu:bionic@sha256:ea3ae7c4aa991ce4d63445bbc55c28a065136fb742d1b39f4d2d6ed43545a224
FROM renovate/ubuntu:focal@sha256:f74b369729c254115d1bbc2cd7a5be8a493953c1ee55875d41121296a41b9f66

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
# Image: dotnet
#--------------------------------------
FROM base as dotnet

COPY src/dotnet/ /usr/local/


#--------------------------------------
# Image: swift
#--------------------------------------
FROM base as swift

COPY src/swift/ /usr/local/

#--------------------------------------
# Image: helm
#--------------------------------------
FROM base as helm

COPY src/helm/ /usr/local/

#--------------------------------------
# Image: powershell
#--------------------------------------
FROM base as powershell

COPY src/powershell/ /usr/powershell/

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
COPY src/dotnet/ /usr/local/
COPY src/swift/ /usr/local/
COPY src/helm/ /usr/local/
COPY src/powershell/ /usr/local/

#--------------------------------------
# Image: final
#--------------------------------------
FROM ${IMAGE} as final
