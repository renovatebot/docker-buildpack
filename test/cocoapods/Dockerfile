ARG IMAGE=renovate/buildpack
FROM ${IMAGE}

# CocoaPods

# renovate: datasource=docker versioning=docker
RUN install-tool ruby 2.5.8


# renovate: datasource=rubygems versioning=ruby
RUN install-gem cocoapods 1.9.1

USER ubuntu

RUN set -ex; \
    git clone --depth=1 https://github.com/renovate-tests/cocoapods1; \
    cd cocoapods1/Project; \
    gem install cocoapods-acknowledgements; \
    pod install; \
    git status -s
