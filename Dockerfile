FROM renovate/ubuntu@sha256:f94cb492cb94e913186e477168dff87ab4c12c08a445d65d511c0cc628369d69

LABEL org.opencontainers.image.source="https://github.com/renovatebot/docker-buildpack"

ADD build/ /usr/local/build/
ADD docker/ /usr/local/docker/

ENTRYPOINT ["/usr/local/docker/entrypoint.sh"]

USER root

RUN ln -sf /usr/local/build/install-tool.sh /usr/local/bin/install-tool
