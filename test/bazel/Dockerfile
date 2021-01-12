ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=github-releases lookupName=bazelbuild/bazelisk
RUN install-tool bazelisk 1.7.5

USER ubuntu

RUN set -ex; bazelisk version
