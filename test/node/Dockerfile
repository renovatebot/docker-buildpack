ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build


# renovate: datasource=docker versioning=docker
RUN install-tool node 12.16.2


RUN touch /.dummy

USER ubuntu

FROM build as testa

SHELL [ "/bin/sh", "-c" ]
ENTRYPOINT [ ]

RUN set -ex; \
  printenv; \
  echo $SHELL; \
  echo "$(command -v node)";

RUN set -ex; \
  [ "$(command -v node)" = "/usr/local/bin/node" ] && echo "works" || exit 1;

RUN node --version

FROM build as testb

RUN npm install -g yarn

RUN set -ex; \
  yarn --version; \
  command -v yarn;

FROM build as testc

USER root

RUN install-tool pnpm 4.14.2

USER ubuntu

RUN set -ex; \
  pnpm --version; \
  command -v pnpm;

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
