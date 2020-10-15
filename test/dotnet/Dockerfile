ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=docker versioning=docker
RUN install-tool dotnet 3.1.403

# renovate: datasource=docker versioning=docker
RUN install-tool dotnet 3.1.403

USER ubuntu 

COPY --chown=ubuntu:0 test test

RUN set -ex; \
    dotnet help

RUN set -ex; \
    cd test; \
    dotnet restore --use-lock-file

RUN set -ex;  \
    cd test; \
    dotnet add package Newtonsoft.Json --version 12.0.3; \
    dotnet restore --force-evaluate
