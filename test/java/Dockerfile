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
RUN install-tool gradle 6.7.1

USER 1000

RUN set -ex; \
  gradle --version;

RUN set -ex; \
  git init .; \
  gradle wrapper; \
  git diff; \
  ./gradlew --version


#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
