ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# Python

# renovate: datasource=docker
RUN install-tool python 3.8.3

#--------------------------------------
# test a
#--------------------------------------
FROM build as testa

RUN touch /.dummy

# try install again, sould skip
RUN install-tool python 3.8.3

USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
  pip install pipenv==2018.11.26; \
  cd test/a; \
  pipenv lock;


#--------------------------------------
# test b
#--------------------------------------
FROM ${IMAGE} as testb

USER root

RUN touch /.dummy

RUN install-tool python 3.8.3

USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
  pip install pipenv==2018.11.26; \
  cd test/a; \
  pipenv lock;

#--------------------------------------
# test c
#--------------------------------------
FROM renovate/ubuntu:20.04 as testc

USER root

RUN touch /.dummy

COPY --from=build /usr/local/build /usr/local/build
COPY --from=build /usr/local/bin /usr/local/bin

# loading env
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

ENTRYPOINT [ "docker-entrypoint.sh" ]


RUN install-apt dumb-init

# renovate: datasource=github lookupName=viceice/python-builds
RUN install-tool python 3.8.3

RUN install-pip pipenv 2018.11.26

USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
  cd test/a; \
  pipenv lock;

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
