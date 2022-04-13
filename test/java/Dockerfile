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
RUN install-tool gradle 7.4.2

USER 1000

RUN mkdir /tmp/src

WORKDIR /tmp/src

RUN set -ex; \
  gradle --version; \
  git --version
  
RUN set -ex; \
  git config --global user.email "renovate@whitesource.com"; \
  git config --global user.name "Renovate Bot"

RUN set -ex; \
  git init .; \
  touch settings.gradle; \
  git add .; git commit -m 'dummy'; \
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
