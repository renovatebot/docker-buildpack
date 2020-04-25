ARG IMAGE=renovate/buildpack
FROM ${IMAGE}


# renovate: datasource=docker versioning=docker
RUN install-tool node 12.16.2


USER ubuntu

ENTRYPOINT [ "/bin/sh" ]

RUN set -ex; \
    node --version
