ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=node
RUN install-tool node v16.13.1

RUN touch /.dummy

COPY --chown=1000:0 test test

WORKDIR /test

USER 1000

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
RUN npm --version

#--------------------------------------
# test: yarn
#--------------------------------------
FROM build as testb

RUN npm install -g yarn

RUN set -ex; \
  [ "$(command -v yarn)" = "/home/${USER_NAME}/.npm-global/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;


RUN set -ex; cd a; yarn

ENV NPM_CONFIG_PREFIX=/tmp/.npm
RUN npm install -g yarn

RUN set -ex; \
  [ "$(command -v yarn)" = "/home/ubuntu/.npm-global/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;


SHELL [ "/bin/sh", "-c" ]

USER root

# renovate: datasource=npm
RUN install-tool yarn 1.22.17

USER 1000

RUN set -ex; \
  [ "$(command -v yarn)" = "/usr/local/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version

#--------------------------------------
# test: pnpm
#--------------------------------------

FROM build as testc

USER root

# renovate: datasource=npm
RUN install-tool pnpm 6.23.1

USER 1000


RUN set -ex; \
  pnpm --version;


RUN set -ex; cd a; pnpm i


SHELL [ "/bin/sh", "-c" ]
RUN set -ex; \
  pnpm --version \
  [ "$(command -v pnpm)" = "/usr/local/bin/pnpm" ] && echo "works" || exit 1;

#--------------------------------------
# test: node 14
#--------------------------------------

FROM ${IMAGE} as testd

# renovate: datasource=node versioning=semver
RUN install-tool node v14.18.2

RUN touch /.dummy

# renovate: datasource=npm
RUN install-tool yarn 1.22.17

USER 1000

COPY --chown=1000:0 test test

RUN set -ex; \
  npm --version; \
  command -v npm;


RUN set -ex; cd test/a; npm i

RUN npm install -g yarn
RUN set -ex; \
  [ "$(command -v yarn)" = "/home/${USER_NAME}/.npm-global/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;

RUN mkdir -p /tmp/.npm/{bin,lib}
ENV NPM_CONFIG_PREFIX=/tmp/.npm
RUN npm install -g yarn

RUN set -ex; \
  [ "$(command -v yarn)" = "/home/ubuntu/.npm-global/bin/yarn" ] && echo "works" || exit 1; \
  yarn --version;

#--------------------------------------
# final
#--------------------------------------
FROM ${IMAGE}

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
