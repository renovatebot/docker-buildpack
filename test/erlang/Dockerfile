ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Erlang

RUN install-tool erlang 22.3.2-1

# Elixir

# renovate: datasource=docker versioning=docker
RUN install-tool elixir 1.11.3

USER ubuntu

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/swarm.git; \
    cd swarm; \
    mix deps.update --all; \
    git status -s;
