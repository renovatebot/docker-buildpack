ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=adoptium-java lookupName=java-jre
RUN install-tool java 11.0.12+7

RUN touch /.dummy

WORKDIR /tmp


#--------------------------------------
# test: gradle
#--------------------------------------
FROM build as testa

# renovate: datasource=gradle-version lookupName=gradle versioning=gradle
RUN install-tool gradle 7.2

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
