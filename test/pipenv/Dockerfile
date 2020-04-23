ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Python

# renovate: datasource=docker
RUN install-tool python 3.8.2


# Pipenv

# renovate: datasource=pypi
ENV PIPENV_VERSION=2018.11.26
RUN install-pip pipenv

USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
    cd test/a; \
    pipenv lock;
