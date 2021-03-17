#--------------------------------------
# Target image to build
#--------------------------------------
ARG TARGET=latest

#--------------------------------------
# Non-root user to create
#--------------------------------------
ARG USER_ID=1000
ARG USER_NAME=user

#--------------------------------------
# Image: base
#--------------------------------------
FROM ubuntu:focal@sha256:b4f9e18267eb98998f6130342baacaeb9553f136142d40959a1b46d6401f0f2b as base

ARG USER_ID
ARG USER_NAME

LABEL maintainer="Rhys Arkins <rhys@arkins.net>" \
  org.opencontainers.image.source="https://github.com/renovatebot/docker-buildpack"

#  autoloading buildpack env
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

COPY src/base/ /usr/local/

RUN install-buildpack

RUN install-apt \
  ca-certificates \
  curl \
  dumb-init \
  gnupg \
  openssh-client \
  unzip \
  xz-utils \
  ;

# renovate: datasource=github-tags lookupName=git/git
RUN install-tool git v2.31.0

# BEGIN: sidecar buildpacks

#--------------------------------------
# Image: dotnet
#--------------------------------------
FROM base as target-dotnet

COPY src/dotnet/ /usr/local/


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
# Image: helm
#--------------------------------------
FROM base as target-helm

COPY src/helm/ /usr/local/


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
# Image: powershell
#--------------------------------------
FROM base as target-powershell

COPY src/powershell/ /usr/local/


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
# Image: swift
#--------------------------------------
FROM base as target-swift

COPY src/swift/ /usr/local/

# END: sidecar buildpacks

#--------------------------------------
# Image: full (latest)
#--------------------------------------
FROM base as target-latest

COPY src/docker/ /usr/local/
COPY src/dotnet/ /usr/local/
COPY src/erlang/ /usr/local/
COPY src/golang/ /usr/local/
COPY src/helm/ /usr/local/
COPY src/java/ /usr/local/
COPY src/node/ /usr/local/
COPY src/php/ /usr/local/
COPY src/powershell/ /usr/local/
COPY src/python/ /usr/local/
COPY src/ruby/ /usr/local/
COPY src/rust/ /usr/local/
COPY src/swift/ /usr/local/


#--------------------------------------
# Image: final
#--------------------------------------
FROM target-${TARGET} as final

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]
