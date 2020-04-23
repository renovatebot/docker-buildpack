ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# CocoaPods

# renovate: datasource=docker depName=ruby versioning=docker
ENV RUBY_VERSION 2.5.8
RUN install-tool ruby


# renovate: datasource=rubygems depName=cocoapods versioning=ruby
ENV COCOAPODS_VERSION 1.9.1
RUN install-gem cocoapods

USER ubuntu

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/cocoapods1; \
    cd cocoapods1/Project; \
    gem install cocoapods-acknowledgements; \
    pod install; \
    git status -s
