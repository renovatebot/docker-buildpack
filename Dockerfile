FROM renovate/ubuntu@sha256:f94cb492cb94e913186e477168dff87ab4c12c08a445d65d511c0cc628369d69

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
