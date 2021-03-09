ARG IMAGE=renovate/buildpack
FROM ${IMAGE} as build

RUN touch /.dummy

# install nginx for request testing
RUN install-apt nginx

COPY src/ /

WORKDIR /test

# create test certs
RUN set -ex; \
  openssl genrsa 2048 > ca.key; \
  openssl genrsa 2048 > renovate.key; \
  openssl req -config ca.conf -x509 -new -nodes -key ca.key -out ca.pem; \
  openssl req -config cert.conf -new -nodes -key renovate.key -out renovate.req; \
  openssl x509 -req -in renovate.req -CA ca.pem -CAkey ca.key -out renovate.pem; \
  rm ca.key

# install root ca
# RUN  set -ex \
#   && cp ca.pem /usr/local/share/ca-certificates/renovate-ca.crt \
#   && update-ca-certificates

# install nginx cert
RUN set -ex; \
  cat renovate.pem ca.pem > /etc/ssl/certs/renovate.pem; \
  cp renovate.key /etc/ssl/private/renovate.key;


#--------------------------------------
# test: curl
#--------------------------------------
FROM build as testa

RUN set -ex; \
  openssl x509 -noout -text -in ca.pem; \
  openssl x509 -noout -text -in renovate.pem;

RUN set -ex; \
  nginx && su -c 'SSL_CERT_FILE=/test/ca.pem curl -svo /dev/null https://localhost' ${USER_NAME}


#--------------------------------------
# test: python
#--------------------------------------
FROM build as testb

# renovate: datasource=github-releases depName=renovatebot/python
ARG PYTHON_VERSION=3.9.2
RUN install-tool python

RUN set -ex; \
  nginx && su -c 'SSL_CERT_FILE=/test/ca.pem python request.py' ${USER_NAME}

#--------------------------------------
# test: node
#--------------------------------------
FROM build as testc

# renovate: datasource=docker versioning=docker
RUN install-tool node 14.16.0

RUN set -ex; \
  nginx && su -c 'NODE_EXTRA_CA_CERTS=/test/ca.pem node request.mjs' ${USER_NAME}

#--------------------------------------
# test: php
#--------------------------------------
FROM build as testd

# old php version, not for renovating
RUN install-tool php 7.4.14

RUN set -ex; \
  nginx && su -c 'SSL_CERT_FILE=/test/ca.pem php request.php' ${USER_NAME}


#--------------------------------------
# test: ruby
#--------------------------------------
FROM build as teste

# Do not renovate ruby 2.x
RUN install-tool ruby 2.6.4

RUN set -ex; \
  nginx && su -c 'SSL_CERT_FILE=/test/ca.pem ruby request.rb' ${USER_NAME}


#--------------------------------------
# final
#--------------------------------------
FROM ${IMAGE}

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
COPY --from=teste /.dummy /.dummy
