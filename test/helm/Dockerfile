ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build


RUN install-tool helm 3.4.0
RUN install-tool helm v3.4.0

USER ubuntu

RUN set -ex; helm version

RUN set -ex; helm repo update
