ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# Do not renovate ruby 2.x
RUN install-tool ruby 2.6.4

RUN touch /.dummy

WORKDIR /tmp

FROM ${IMAGE} as build3

# renovate: datasource=github-releases lookupName=containerbase/ruby-prebuild versioning=ruby
RUN install-tool ruby 3.1.0

RUN touch /.dummy

WORKDIR /tmp

#--------------------------------------
# test: bundler
#--------------------------------------
FROM build as testa


# openshift
USER 1005

RUN ruby --version
RUN gem env

RUN gem install bundler -v 1.17.2

RUN bundle env

RUN set -ex; \
  [ "$(command -v bundle)" = "/home/${USER_NAME}/bin/bundle" ] && echo "works" || exit 1; \
  bundler env

RUN set -ex; \
    cd a; \
    bundle lock

#--------------------------------------
# test: global bundler
#--------------------------------------
FROM build as testb

# renovate: datasource=rubygems versioning=ruby
RUN install-gem bundler 2.3.5

USER 1000

RUN ruby --version
RUN bundler env

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/bundler8; \
    cd bundler8; \
    bundle lock; \
    git status -s

SHELL [ "/bin/sh", "-c" ]
RUN ruby --version

#--------------------------------------
# test: cocoapods
#--------------------------------------
FROM build as testc

USER 1000

RUN gem install cocoapods -v 1.9.1

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/cocoapods1; \
    cd cocoapods1/Project; \
    gem install cocoapods-acknowledgements; \
    pod install; \
    git status -s

#--------------------------------------
# test: global cocoapods
#--------------------------------------
FROM build3 as testd

# renovate: datasource=rubygems versioning=ruby
RUN install-gem cocoapods 1.11.2

USER 1000

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/cocoapods1; \
    cd cocoapods1/Project; \
    gem install cocoapods-acknowledgements; \
    pod install; \
    git status -s



#--------------------------------------
# final
#--------------------------------------
FROM build

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
