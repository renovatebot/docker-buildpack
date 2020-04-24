FROM renovate/ubuntu@sha256:b9a91b5e54d32186439ee889fe903d633e6c6f574b7f542a482cf63f2a1d9ea3

LABEL org.opencontainers.image.source="https://github.com/renovatebot/docker-buildpack"

USER root

# Zombie killer: https://github.com/Yelp/dumb-init#readme
RUN apt-get update && \
    apt-get install -y dumb-init && \
    rm -rf /var/lib/apt/lists/*

# loading env
ENV BASH_ENV=/usr/local/etc/env
SHELL ["/bin/bash" , "-c"]

ENTRYPOINT [ "docker-entrypoint.sh" ]

ADD build/ /usr/local/build/
ADD bin/ /usr/local/bin/
