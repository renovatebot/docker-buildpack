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
  openssl req -config cert.conf -new -nodes -key renovate.key -out renovate.csr; \
  openssl x509 -req -in renovate.csr -CA ca.pem -CAkey ca.key -out renovate.pem -extfile cert.conf -extensions v3_req; \
  rm ca.key; \
  cat renovate.pem ca.pem > renovate-chain.pem;

# install root ca
# RUN  set -ex \
#   && cp ca.pem /usr/local/share/ca-certificates/renovate-ca.crt \
#   && update-ca-certificates


#--------------------------------------
# test: curl
#--------------------------------------
FROM build as testa

RUN set -ex; \
  openssl x509 -noout -text -in ca.pem; \
  openssl x509 -noout -text -in renovate.pem;

RUN set -ex; \
  nginx \
  && su -c 'SSL_CERT_FILE=/test/ca.pem curl -svo /dev/null https://localhost' ${USER_NAME} \
  && su -c 'SSL_CERT_FILE=/test/ca.pem curl -svo /dev/null https://buildkitsandbox' ${USER_NAME}

# install root ca
RUN  set -ex \
  && cp ca.pem /usr/local/share/ca-certificates/renovate-ca.crt \
  && update-ca-certificates

# use global root certs
RUN set -ex; \
  nginx \
  && su -c 'curl -svo /dev/null https://buildkitsandbox' ${USER_NAME}

#--------------------------------------
# test: python
#--------------------------------------
FROM build as testb

# renovate: datasource=github-releases depName=python lookupName=containerbase/python-prebuild
ARG PYTHON_VERSION=3.10.8
RUN install-tool python

RUN set -ex; \
  nginx && su -c 'SSL_CERT_FILE=/test/ca.pem python request.py' ${USER_NAME}

#--------------------------------------
# test: node
#--------------------------------------
FROM build as testc

# renovate: datasource=node
RUN install-tool node v16.18.0

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
# test: powershell
#--------------------------------------
FROM build as testf

# renovate: datasource=github-releases lookupName=PowerShell/PowerShell
RUN install-tool powershell v7.2.7

RUN set -ex; cat /etc/hosts; \
  nginx && SSL_CERT_FILE=/test/ca.pem pwsh -c "&{ \$ErrorActionPreference='Stop'; invoke-webrequest https://buildkitsandbox }"

#--------------------------------------
# final
#--------------------------------------
FROM ${IMAGE}

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
COPY --from=testd /.dummy /.dummy
COPY --from=teste /.dummy /.dummy
COPY --from=testf /.dummy /.dummy
