ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Erlang

# renovate: datasource=github-releases lookupName=containerbase/erlang-prebuild versioning=docker
RUN install-tool erlang 24.3.4.6

# Elixir

# renovate: datasource=docker versioning=docker
RUN install-tool elixir 1.14.1

WORKDIR /tmp

USER 1000

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/swarm.git; \
    cd swarm; \
    mix deps.update --all; \
    git status -s;
