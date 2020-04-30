#--------------------------------------
# Target image to build
#--------------------------------------
ARG IMAGE=latest

#--------------------------------------
# Image: base
#--------------------------------------
FROM renovate/ubuntu@sha256:b9a91b5e54d32186439ee889fe903d633e6c6f574b7f542a482cf63f2a1d9ea3 as base

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

ADD src/base/ /usr/local/


#--------------------------------------
# Image: golang
#--------------------------------------
FROM base as golang

ADD src/golang/ /usr/local/


#--------------------------------------
# Image: java
#--------------------------------------
FROM base as java

ADD src/java/ /usr/local/


#--------------------------------------
# Image: node
#--------------------------------------
FROM base as node

ADD src/node/ /usr/local/


#--------------------------------------
# Image: python
#--------------------------------------
FROM base as python

ADD src/python/ /usr/local/


#--------------------------------------
# Image: ruby
#--------------------------------------
FROM base as ruby

ADD src/ruby/ /usr/local/


#--------------------------------------
# Image: full (latest)
#--------------------------------------
FROM base as latest

ADD src/docker/ /usr/local/
ADD src/erlang/ /usr/local/
ADD src/golang/ /usr/local/
ADD src/java/ /usr/local/
ADD src/node/ /usr/local/
ADD src/php/ /usr/local/
ADD src/python/ /usr/local/
ADD src/ruby/ /usr/local/
ADD src/rust/ /usr/local/


#--------------------------------------
# Image: final
#--------------------------------------
FROM ${IMAGE} as final
