FROM alpine:latest

ENV COMPOSE_VERSION 1.7.1

RUN \
  apk add --update \
    bash \
    curl \
    jq \
    py-pip \
    py-yaml && \
  pip install -U docker-compose==${COMPOSE_VERSION} &&\
  rm /var/cache/apk/* && \
  rm -rf `find / -regex '.*\.py[co]' -or -name apk`

COPY config /usr/local/bin/config
COPY bin /usr/local/bin
COPY VERSION /usr/local/bin

ENTRYPOINT ["nib"]
CMD ["--help"]
