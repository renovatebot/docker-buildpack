ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

RUN touch /.dummy

# Python

# renovate: datasource=docker
RUN install-tool python 3.8.3

USER ubuntu

COPY --chown=ubuntu:0 test test


#--------------------------------------
# build: pipenv
#--------------------------------------
FROM build as pipenv

RUN pip install pipenv==2018.11.26


#--------------------------------------
# build: poetry
#--------------------------------------
FROM build as poetry

RUN pip install poetry==1.0.5


#--------------------------------------
# test a: build
#--------------------------------------
FROM build as testa

USER root

# try install again, sould skip
RUN install-tool python 3.8.3


#--------------------------------------
# test b: pipenv
#--------------------------------------
FROM pipenv as testb

RUN set -ex; \
  cd test/a; \
  pipenv lock;


#--------------------------------------
# test c: poetry
#--------------------------------------
FROM poetry as testc

RUN RUN set -ex; cd test/c-poetry && poetry update --lock --no-interaction


#--------------------------------------
# test d: poetry
#--------------------------------------
FROM poetry as testd

RUN set -ex; cd test/d-poetry && poetry update --lock --no-interaction pytest


#--------------------------------------
# test e: poetry
#--------------------------------------
FROM poetry as teste

RUN set -ex; \
  git clone --depth=1 https://github.com/renovate-tests/poetry1; \
  cd poetry1; \
  poetry update --lock --no-interaction pytest; \
  git status -s; \
  git checkout -f; \
  git clean -fdx; \
  poetry update --lock --no-interaction; \
  git status -s;


#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
COPY --from=teste /.dummy /.dummy
