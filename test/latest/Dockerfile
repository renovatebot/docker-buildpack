ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

RUN touch /.dummy


# renovate: datasource=github-releases depName=renovatebot/python
ARG PYTHON_VERSION=3.9.2
RUN install-tool python
