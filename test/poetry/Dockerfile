ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Python

# renovate: datasource=docker depName=python
ENV PYTHON_VERSION=3.8.2
RUN install-tool python

# Poetry

# renovate: datasource=github-releases depName=python-poetry/poetry
ENV POETRY_VERSION=1.0.5
RUN install-tool poetry

USER ubuntu

COPY --chown=ubuntu:0 test test

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
