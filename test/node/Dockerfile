ARG IMAGE=renovate/buildpack
FROM ${IMAGE}


# renovate: datasource=docker versioning=docker
RUN install-tool node 12.16.2


USER ubuntu

SHELL [ "/bin/sh", "-c" ]
ENTRYPOINT [ ]

RUN set -ex; \
  printenv; \
  echo $SHELL; \
  echo "$(command -v node)";

RUN set -ex; \
  [ "$(command -v node)" = "/usr/local/bin/node" ] && echo "works" || exit 1;

RUN node --version
