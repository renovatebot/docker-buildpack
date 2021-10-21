![Build status](https://github.com/renovatebot/docker-buildpack/workflows/build/badge.svg)
![Docker Image Size (latest)](https://img.shields.io/docker/image-size/renovate/buildpack/latest)
![GitHub](https://img.shields.io/github/license/renovatebot/docker-buildpack)

# docker-buildpack

This repository is the source for the Docker Hub image `renovate/buildpack`. Commits to `main` branch are automatically built and published.

## Notice: Do not use the laguage docker tags

Do not use the language docker tags, they are deprecated and won't be updated soon.

## Notice: Intention to Relocate

We are currently in the process of removing all buildpack-related repository content to its new home at <https://github.com/containerbase>.
Please create an issue to check first before starting any major work on bugs or features.

## Custom base image

To use a custom base image with `renovate/buildpack` checkout [custom-base-image](https://github.com/containerbase/buildpack/blob/main/docs/custom-base-image.md) docs.

### Custom Root CA Certificates

To add custom root certifactes to the `renovate/buildpack` base image checkout [custom-root-ca](https://github.com/containerbase/buildpack/blob/main/docs/custom-root-ca.md) docs.
