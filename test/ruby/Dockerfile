ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# renovate: datasource=ruby-version depName=ruby-version versioning=ruby
RUN install-tool ruby 2.6.4

RUN touch /.dummy

#--------------------------------------
# test: bundler
#--------------------------------------
FROM build as testa

USER 1000

RUN ruby --version

RUN gem install bundler -v 1.17.2

RUN set -ex; \
  [ "$(command -v bundle)" = "/home/${USER_NAME}/.gem-global/bin/bundle" ] && echo "works" || exit 1; \
  bundler env

ENV GEM_HOME=/tmp/.gem

RUN gem install bundler -v 1.17.2

RUN set -ex; \
  [ "$(command -v bundle)" = "/tmp/.gem/bin/bundle" ] && echo "works" || exit 1; \
  bundler env

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/bundler8; \
    cd bundler8; \
    bundle lock; \
    git status -s

#--------------------------------------
# test: global bundler
#--------------------------------------
FROM build as testb

RUN install-gem bundler 1.17.2

USER 1000

RUN ruby --version
RUN bundler env

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/bundler8; \
    cd bundler8; \
    bundle lock; \
    git status -s

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
FROM build as testd

# renovate: datasource=rubygems versioning=ruby
RUN install-gem cocoapods 1.10.1

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
