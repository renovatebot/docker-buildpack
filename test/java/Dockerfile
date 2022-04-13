ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=adoptium-java lookupName=java-jre
RUN install-tool java 17.0.2+8

RUN touch /.dummy

RUN mkdir -m 770 /src

WORKDIR /src


#--------------------------------------
# test: gradle
#--------------------------------------
FROM build as testa

# renovate: datasource=gradle-version lookupName=gradle versioning=gradle
RUN install-tool gradle 7.4.2

USER 1000

RUN set -ex; \
  gradle --version; \
  git --version

RUN set -ex; \
  git init .; \
  touch settings.gradle; \
  git commit -A -m 'dummy'; \
  gradle wrapper; \
  ls -la; \
  git diff; \
  ./gradlew --version

SHELL [ "/bin/sh", "-c" ]
RUN gradle --version

#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
