ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build


# renovate: datasource=docker versioning=docker
RUN install-tool node 15.7.0

RUN touch /.dummy

USER ubuntu

COPY --chown=ubuntu:0 test test

#--------------------------------------
# test: node
#--------------------------------------
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

#--------------------------------------
# test: yarn
#--------------------------------------
FROM build as testb


RUN npm install -g yarn

RUN set -ex; \
  [ "$(command -v yarn)" = "/home/ubuntu/.npm-global/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;


RUN set -ex; cd test/a; yarn


ENV NPM_CONFIG_PREFIX=/tmp/.npm
RUN npm install -g yarn

RUN set -ex; \
  [ "$(command -v yarn)" = "/tmp/.npm/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;


#--------------------------------------
# test: pnpm
#--------------------------------------

FROM build as testc

USER root

RUN install-tool pnpm 4.14.2

USER ubuntu


RUN set -ex; \
  pnpm --version; \
  command -v pnpm;


RUN set -ex; cd test/a; pnpm i

#--------------------------------------
# test: node 15
#--------------------------------------

FROM ${IMAGE} as testd

RUN install-tool node 15.0.1

RUN touch /.dummy

RUN install-tool yarn 1.22.5

USER ubuntu

COPY --chown=ubuntu:0 test test

RUN set -ex; \
  npm --version; \
  command -v npm;


RUN set -ex; cd test/a; npm i

RUN npm install -g yarn
RUN set -ex; \
  [ "$(command -v yarn)" = "/home/ubuntu/.npm-global/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;

RUN mkdir -p /tmp/.npm/{bin,lib}
ENV NPM_CONFIG_PREFIX=/tmp/.npm
RUN npm install -g yarn

RUN set -ex; \
  [ "$(command -v yarn)" = "/tmp/.npm/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;

#--------------------------------------
# final
#--------------------------------------
FROM ${IMAGE}

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
