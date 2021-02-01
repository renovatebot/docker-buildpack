ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

RUN install-tool powershell 7.1.0

USER 1000

RUN set -ex; \
  pwsh -Version

RUN set -ex; \
  pwsh -Command Write-Host Hello, World!
