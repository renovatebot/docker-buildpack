ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build


RUN touch /.dummy

#--------------------------------------
# test: golang
#--------------------------------------
FROM build as testa

# renovate: datasource=docker versioning=docker
RUN install-tool golang 1.14.14

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

#--------------------------------------
# test: check first patch version eg v1.11.0
#--------------------------------------
FROM build as testb

# do not update patch version
RUN install-tool golang 1.11.0

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/gomod1; \
    cd gomod1; \
    go get -d ./...; \
    git status -s; \
    git checkout -f; \
    git clean -fdx; \
    go mod tidy; \
    git status -s;

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
