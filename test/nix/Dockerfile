ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=github-tags lookupName=NixOS/nix
RUN install-tool nix 2.3.16

USER 1000

RUN set -ex; \
  nix --version

RUN set -ex; \
  nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version'

RUN set -ex; \
  nix-instantiate --eval -E 'with import <nixpkgs> {}; glibc.version'
