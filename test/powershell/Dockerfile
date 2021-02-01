ARG BASE_IMAGE=renovate/buildpack
FROM ${BASE_IMAGE} as build

RUN install-tool powershell 7.1.0

USER ubuntu

RUN set -ex; \
  pwsh -Version

RUN set -ex; \
  pwsh -Command Write-Host Hello, World!
