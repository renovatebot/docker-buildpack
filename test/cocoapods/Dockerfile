FROM renovate/buildpack

# CocoaPods

RUN install-tool ruby 2.5

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
