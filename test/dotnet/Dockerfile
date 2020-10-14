ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=docker versioning=docker
RUN install-tool dotnet 3.1.403

# renovate: datasource=docker versioning=docker
RUN install-tool dotnet 3.1.403

USER 1000

RUN set -ex; \
    dotnet version
