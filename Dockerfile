#--------------------------------------
# Non-root user to create
#--------------------------------------
ARG USER_ID=1000
ARG USER_NAME=ubuntu

#--------------------------------------
# Image: containerbase/buildpack
#--------------------------------------
FROM containerbase/buildpack:4.13.2@sha256:a608e5c9784ec73cd4779d4fc6a2ae9214e3e42f7ebf1e3e66311b0523e94c69 AS buildpack

#--------------------------------------
# Image: base
#--------------------------------------
FROM ubuntu:focal@sha256:514c495036e344710402a1de098e2b81aee8727210d11c36e36aa4e44ec157d8

ARG USER_ID
ARG USER_NAME


# Weekly cache buster
ARG CACHE_WEEK

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
RUN install-tool git v2.37.2
