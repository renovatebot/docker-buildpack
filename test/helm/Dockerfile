ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build


RUN install-tool helm 3.4.0

USER 1000

RUN set -ex; helm version

RUN set -ex; \
  helm repo add stable https://charts.helm.sh/stable; \
  helm repo update
