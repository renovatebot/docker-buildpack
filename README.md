![Build status](https://github.com/renovatebot/docker-buildpack/workflows/build/badge.svg)
![Docker Image Size (latest)](https://img.shields.io/docker/image-size/renovate/buildpack/latest)
![GitHub](https://img.shields.io/github/license/renovatebot/docker-buildpack)

# docker-buildpack

This repository is the source for the Docker Hub image `renovate/buildpack`. Commits to `main` branch are automatically built and published.

## Notice: Do not use this image

Do not use the `renovate/buildpack` docker images, they are deprecated.
Use [`containerbase/buildpack`](https://github.com/containerbase/buildpack) image.

## Notice: Intention to Relocate

We are currently in the process of removing all buildpack-related repository content to its new home at <https://github.com/containerbase>.
Please create an issue to check first before starting any major work on bugs or features.

## Custom base image

To use a custom base image with `containerbase/buildpack` checkout [custom-base-image](https://github.com/containerbase/buildpack/blob/main/docs/custom-base-image.md) docs.

### Custom Root CA Certificates

To add custom root certifactes to the `containerbase/buildpack` base image checkout [custom-root-ca](https://github.com/containerbase/buildpack/blob/main/docs/custom-root-ca.md) docs.
