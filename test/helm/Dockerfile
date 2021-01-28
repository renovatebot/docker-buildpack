ARG TARGET=renovate/buildpack
FROM ${TARGET} as build


RUN install-tool helm 3.4.0

USER ubuntu

RUN set -ex; helm version

RUN set -ex; \
  helm repo add stable https://charts.helm.sh/stable; \
  helm repo update
