ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=docker depName=openjdk versioning=docker
RUN install-tool java 11

# renovate: datasource=gradle-version depName=gradle versioning=gradle
RUN install-tool gradle 6.7.1


USER 1000

RUN set -ex: \
  gradle --version
