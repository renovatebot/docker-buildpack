ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=adoptium-java lookupName=java-jre
RUN install-tool java 17.0.2+8

RUN touch /.dummy

WORKDIR /tmp


#--------------------------------------
# test: gradle
#--------------------------------------
FROM build as testa

# renovate: datasource=gradle-version lookupName=gradle versioning=gradle
RUN install-tool gradle 7.4.1

USER 1000

RUN set -ex; \
  gradle --version;

RUN set -ex; \
  git init .; \
  touch settings.gradle; \
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
