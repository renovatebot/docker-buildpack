![Build status](https://github.com/renovatebot/docker-buildpack/workflows/build/badge.svg)
![Docker Image Size (latest)](https://img.shields.io/docker/image-size/renovate/buildpack/latest)
![GitHub](https://img.shields.io/github/license/renovatebot/docker-buildpack)


# docker-buildpack

This repository is the source for the Docker Hub image `renovate/buildpack`. Commits to `master` branch are automatically built and published.


### Custom base image

```dockerfile
# This buildpack is used for tool intallation and user/directory setup
FROM renovate/buildpack:4 AS buildpack

# currently only ubuntu focal based distro suported
FROM ubuntu:focal as base

# The buildpack supports custom user but Renovate requires ubuntu
ARG USER_NAME=ubuntu
ARG USER_ID=1000
ARG APP_ROOT=/usr/src/app

# Set env and shell
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

# Set up buildpack
COPY --from=buildpack /usr/local/bin/ /usr/local/bin/
COPY --from=buildpack /usr/local/buildpack/ /usr/local/buildpack/
RUN install-buildpack

# These packages are required for installs and runtime
RUN install-apt \
  dumb-init \
  gnupg \
  curl \
  ca-certificates \
  unzip \
  xz-utils \
  openssh-client

# renovate: datasource=github-tags lookupName=git/git
RUN install-tool git v2.30.0
# renovate: datasource=docker versioning=docker
RUN install-tool node 14.15.4
# renovate: datasource=npm versioning=npm
RUN install-tool yarn 1.22.10

WORKDIR ${APP_ROOT}

# This entry point ensures that dumb-init is run
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "bash" ]

USER $UBUNTU_ID
```
