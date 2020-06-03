ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=docker versioning=docker
RUN install-tool rust 1.43.1

RUN rustup toolchain list

USER 1000

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/cargo1; \
    cd cargo1; \
    cargo update; \
    git status -s
