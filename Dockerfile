#--------------------------------------
# Target image to build
#--------------------------------------
ARG TARGET=latest

#--------------------------------------
# Non-root user to create
#--------------------------------------
ARG USER_ID=1000
ARG USER_NAME=ubuntu

#--------------------------------------
# Image: containerbase/buildpack
#--------------------------------------
FROM containerbase/buildpack:1.15.0@sha256:e506454ba201d52df4d75fdf2b21f2c54a92dce501f512427c54680c6cbd3bb7 AS buildpack

#--------------------------------------
# Image: base
#--------------------------------------
FROM ubuntu:focal@sha256:82becede498899ec668628e7cb0ad87b6e1c371cb8a1e597d83a47fac21d6af3 as base

ARG USER_ID
ARG USER_NAME

LABEL maintainer="Rhys Arkins <rhys@arkins.net>" \
  org.opencontainers.image.source="https://github.com/renovatebot/docker-buildpack"

#  autoloading buildpack env
ENV BASH_ENV=/usr/local/etc/env PATH=/home/$USER_NAME/bin:$PATH
SHELL ["/bin/bash" , "-c"]

# This entry point ensures that dumb-init is run
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "bash" ]

# Set up buildpack
COPY --from=buildpack /usr/local/bin/ /usr/local/bin/
COPY --from=buildpack /usr/local/buildpack/ /usr/local/buildpack/
RUN install-buildpack


# renovate: datasource=github-tags lookupName=git/git
RUN install-tool git v2.33.0

# BEGIN: sidecar buildpacks

#--------------------------------------
# Image: dotnet
#--------------------------------------
FROM base as target-dotnet


#--------------------------------------
# Image: erlang
#--------------------------------------
FROM base as target-erlang


#--------------------------------------
# Image: golang
#--------------------------------------
FROM base as target-golang


#--------------------------------------
# Image: helm
#--------------------------------------
FROM base as target-helm


#--------------------------------------
# Image: java
#--------------------------------------
FROM base as target-java

#--------------------------------------
# Image: nix
#--------------------------------------
FROM base as target-nix


#--------------------------------------
# Image: node
#--------------------------------------
FROM base as target-node


#--------------------------------------
# Image: php
#--------------------------------------
FROM base as target-php


#--------------------------------------
# Image: powershell
#--------------------------------------
FROM base as target-powershell


#--------------------------------------
# Image: python
#--------------------------------------
FROM base as target-python


#--------------------------------------
# Image: ruby
#--------------------------------------
FROM base as target-ruby


#--------------------------------------
# Image: rust
#--------------------------------------
FROM base as target-rust


#--------------------------------------
# Image: swift
#--------------------------------------
FROM base as target-swift


# END: sidecar buildpacks

#--------------------------------------
# Image: full (latest)
#--------------------------------------
FROM base as target-latest


#--------------------------------------
# Image: final
#--------------------------------------
FROM target-${TARGET} as final
