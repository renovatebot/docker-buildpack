ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build


RUN touch /.dummy

COPY --chown=1000:0 test test

WORKDIR /test

#--------------------------------------
# test: golang
#--------------------------------------
FROM build as testa

# renovate: datasource=docker versioning=docker
RUN install-tool golang 1.19.3

USER 1000


RUN set -ex; cd a; go get -d ./...; cat go.sum; go mod tidy; cat go.sum

RUN set -ex; cd b; cat go.sum; go mod tidy; cat go.sum

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/gomod1; \
    cd gomod1; \
    go get -d ./...; \
    git status -s; \
    git checkout -f; \
    git clean -fdx; \
    go mod tidy; \
    git status -s;

USER root
RUN echo export "GOPATH=/home/${USER_NAME}/.go" | tee -a $BASH_ENV

USER 1000
RUN go env
RUN set -ex; cd c; go get -d ./...; cat go.sum

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

USER 1000

SHELL [ "/bin/sh", "-c" ]
RUN go env

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
