ARG TARGET=renovate/buildpack
FROM ${TARGET} as build

# renovate: datasource=docker versioning=docker
RUN install-tool rust 1.43.1

# renovate: datasource=docker versioning=docker
RUN install-tool rust 1.43.1

USER 1000


RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/cargo1; \
    cd cargo1; \
    cargo update; \
    git status -s

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/tikv; \
    cd tikv; \
    cargo update --manifest-path Cargo.toml --package fail; \
    git status -s
