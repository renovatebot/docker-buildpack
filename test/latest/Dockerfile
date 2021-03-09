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
RUN  set -ex \
  && cp ca.pem /usr/local/share/ca-certificates/renovate-ca.crt \
  && update-ca-certificates

# install nginx cert
RUN set -ex; \
  cp renovate.pem /etc/ssl/certs/renovate.pem; \
  cp renovate.key /etc/ssl/private/renovate.key;


#--------------------------------------
# test: curl
#--------------------------------------
FROM build as testa

RUN set -ex; \
  openssl x509 -noout -text -in ca.pem; \
  openssl x509 -noout -text -in renovate.pem;

RUN set -ex; \
  nginx && curl -svo /dev/null https://localhost


#--------------------------------------
# test: python
#--------------------------------------
FROM build as testb

# renovate: datasource=github-releases depName=renovatebot/python
ARG PYTHON_VERSION=3.9.2
RUN install-tool python

RUN set -ex; \
  nginx && su -c 'python request.py' ${USER_NAME}

#--------------------------------------
# test: node
#--------------------------------------
FROM build as testc

# renovate: datasource=docker versioning=docker
RUN install-tool node 14.16.0

ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
RUN set -ex; \
  nginx && su -c 'node request.mjs' ${USER_NAME}


#--------------------------------------
# final
#--------------------------------------
FROM ${IMAGE}

COPY --from=testa /.dummy /.dummy
COPY --from=testb /.dummy /.dummy
COPY --from=testc /.dummy /.dummy
