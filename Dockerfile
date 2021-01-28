#--------------------------------------
# Target image to build
#--------------------------------------
ARG TARGET=latest

#--------------------------------------
# Ubuntu base image to use
#--------------------------------------
ARG FLAVOR=bionic
ARG BASE_IMAGE=${FLAVOR}
ARG USER_NAME=ubuntu
ARG USER_ID=1000
ARG APP_ROOT=/usr/src/app

#--------------------------------------
# renovate rebuild trigger
#--------------------------------------
FROM ubuntu:bionic@sha256:ea188fdc5be9b25ca048f1e882b33f1bc763fb976a8a4fea446b38ed0efcbeba as latest
FROM ubuntu:bionic@sha256:ea188fdc5be9b25ca048f1e882b33f1bc763fb976a8a4fea446b38ed0efcbeba as bionic
FROM ubuntu:focal@sha256:703218c0465075f4425e58fac086e09e1de5c340b12976ab9eb8ad26615c3715 as focal

#--------------------------------------
# Image: base
#--------------------------------------
FROM ${BASE_IMAGE} as base

ARG BUILDPACK_VERSION=custom
ARG USER_NAME
ARG USER_ID
ARG APP_ROOT

LABEL maintainer="Rhys Arkins <rhys@arkins.net>" \
  org.opencontainers.image.source="https://github.com/renovatebot/docker-buildpack" \
  org.opencontainers.image.version="${BUILDPACK_VERSION}"

# loading env
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

ENTRYPOINT ["/bin/bash" , "-c", "docker-entrypoint.sh" ]

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

WORKDIR ${APP_ROOT}

COPY src/base/ /usr/local/

RUN install-buildpack

RUN install-apt \
  dumb-init \
  gnupg \
  curl \
  ca-certificates \
  unzip \
  xz-utils \
  openssh-client

# renovate: datasource=github-tags
RUN install-tool git v2.29.2

#--------------------------------------
# Image: erlang
#--------------------------------------
FROM base as target-erlang

COPY src/erlang/ /usr/local/


#--------------------------------------
# Image: golang
#--------------------------------------
FROM base as target-golang

COPY src/golang/ /usr/local/


#--------------------------------------
# Image: java
#--------------------------------------
FROM base as target-java

COPY src/java/ /usr/local/


#--------------------------------------
# Image: node
#--------------------------------------
FROM base as target-node

COPY src/node/ /usr/local/


#--------------------------------------
# Image: php
#--------------------------------------
FROM base as target-php

COPY src/php/ /usr/local/


#--------------------------------------
# Image: python
#--------------------------------------
FROM base as target-python

COPY src/python/ /usr/local/


#--------------------------------------
# Image: ruby
#--------------------------------------
FROM base as target-ruby

COPY src/ruby/ /usr/local/


#--------------------------------------
# Image: rust
#--------------------------------------
FROM base as target-rust

COPY src/rust/ /usr/local/


#--------------------------------------
# Image: dotnet
#--------------------------------------
FROM base as target-dotnet

COPY src/dotnet/ /usr/local/


#--------------------------------------
# Image: swift
#--------------------------------------
FROM base as target-swift

COPY src/swift/ /usr/local/


#--------------------------------------
# Image: helm
#--------------------------------------
FROM base as target-helm

COPY src/helm/ /usr/local/


#--------------------------------------
# Image: powershell
#--------------------------------------
FROM base as target-powershell

COPY src/powershell/ /usr/powershell/


#--------------------------------------
# Image: full (latest)
#--------------------------------------
FROM base as target-latest

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
FROM target-${TARGET} as final

ARG USER_ID

USER ${USER_ID}

CMD ["bash"]
