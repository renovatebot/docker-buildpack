ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=docker lookupName=openjdk versioning=java
RUN install-tool java 11

RUN touch /.dummy

WORKDIR /tmp


#--------------------------------------
# test: gradle
#--------------------------------------
FROM build as testa

# renovate: datasource=gradle-version lookupName=gradle versioning=gradle
RUN install-tool gradle 7.0.2

USER 1000

RUN set -ex; \
  gradle --version;

RUN set -ex; \
  git init .; \
  gradle wrapper; \
  git diff; \
  ./gradlew --version

SHELL [ "/bin/sh", "-c" ]
RUN gradle --version

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
