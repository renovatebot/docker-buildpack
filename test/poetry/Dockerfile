ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Python

# renovate: datasource=docker
RUN install-tool python 3.8.2


USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; pip install poetry==1.0.5

RUN set -ex; cd test/a && poetry update --lock --no-interaction

RUN set -ex; cd test/b && poetry update --lock --no-interaction pytest

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/poetry1; \
    cd poetry1; \
    poetry update --lock --no-interaction pytest; \
    git status -s; \
    git checkout -f; \
    git clean -fdx; \
    poetry update --lock --no-interaction; \
    git status -s;
