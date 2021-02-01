ARG BASE_IMAGE=renovate/buildpack
FROM ${BASE_IMAGE} as build

RUN install-tool swift 5.3.0

RUN touch /.dummy


#--------------------------------------
# testa: swift 5.3
#--------------------------------------
FROM build as testa

USER 1000

RUN swift --version

COPY --chown=ubuntu:0 test test

RUN set -ex; \
  cd test/a; \
  swift package resolve

RUN set -ex; \
  cd test/b; \
  swift package resolve

RUN set -ex; \
  cd test/c; \
  swift package resolve


#--------------------------------------
# testb: swift 5.2.5
#--------------------------------------
FROM build as testb

RUN install-tool swift 5.2.5

USER 1000

RUN swift --version

COPY --chown=ubuntu:0 test test


RUN set -ex; \
  cd test/c; \
  swift package resolve

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
