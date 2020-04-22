ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Python

# renovate: datasource=docker depName=python
ENV PYTHON_VERSION=3.8.2
RUN install-tool python


# Pipenv

# renovate: datasource=pypi depName=pipenv
ENV PIPENV_VERSION=2018.11.26
RUN install-pip pipenv

USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
    cd test/a; \
    pipenv lock;
