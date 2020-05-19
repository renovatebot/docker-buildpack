ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

# Ruby

# renovate: datasource=ruby-version depName=ruby-version versioning=ruby
RUN install-tool ruby 2.5.0

USER 1000

RUN ruby --version

RUN gem install bundler

RUN bundler --version
