ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Python

# renovate: datasource=docker
RUN install-tool python 3.8.2


USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
    pip install --user pipenv; \
    cd test/a; \
    pipenv lock;
