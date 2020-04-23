ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# Golang

# go suggests: git svn bzr mercurial
# git already installed

# renovate: datasource=docker versioning=docker
RUN install-tool golang 1.14.2

USER ubuntu

COPY --chown=ubuntu:0 test test


RUN set -ex; cd test/a; go get -d ./...; cat go.sum; go mod tidy; cat go.sum

RUN set -ex; cd test/b; cat go.sum; go mod tidy; cat go.sum

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/gomod1; \
    cd gomod1; \
    go get -d ./...; \
    git status -s; \
    git checkout -f; \
    git clean -fdx; \
    go mod tidy; \
    git status -s;

ENV GOPATH=/home/ubuntu/.go

RUN go env
RUN set -ex; cd test/c; go get -d ./...; cat go.sum
