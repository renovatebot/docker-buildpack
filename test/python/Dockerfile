ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# Python

# renovate: datasource=docker
RUN install-tool python 3.9.1

RUN touch /.dummy

WORKDIR /tmp

USER 1000

COPY --chown=1000:0 test test


#--------------------------------------
# build: pipenv
#--------------------------------------
FROM build as pipenv

# renovate: datasource=pypi
RUN install-pip pipenv 2018.11.26


#--------------------------------------
# build: poetry
#--------------------------------------
FROM build as poetry

# renovate: datasource=pypi
RUN install-pip poetry 1.0.10


#--------------------------------------
# test a: build
#--------------------------------------
FROM build as testa

USER root

# try install again, sould skip
# renovate: datasource=docker
RUN install-tool python 3.9.1

USER 1000

RUN pip install poetry

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

RUN set -ex; cd test/c-poetry && poetry update --lock --no-interaction


RUN set -ex; cd test/c-poetry && poetry add h3py


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
# test f: pip_requirements
#--------------------------------------
FROM build as testf

RUN pip install hashin

RUN set -ex; \
  cd test/f; \
  hashin distribute==0.6.27; \
  cat requirements.txt


#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
COPY --from=teste /.dummy /.dummy
COPY --from=testf /.dummy /.dummy
