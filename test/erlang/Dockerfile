ARG BASE_IMAGE=renovate/buildpack
FROM ${BASE_IMAGE}

# Erlang

# renovate: datasource=github-releases lookupName=erlang/otp versioning=loose
RUN install-tool erlang 22.3.2

# Elixir

# renovate: datasource=docker versioning=docker
RUN install-tool elixir 1.11.3

USER ubuntu

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/swarm.git; \
    cd swarm; \
    mix deps.update --all; \
    git status -s;
