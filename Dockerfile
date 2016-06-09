FROM alpine:latest

ENV COMPOSE_VERSION 1.7.1

ENV YAML2JSON_VERSION 415420a6f431f7ccbbc22cde0007e3ecadc73253
ENV YAML2JSON_URL https://github.com/bronze1man/yaml2json/blob
ENV YAML2JSON_PATH builds/linux_amd64/yaml2json?raw=true
ENV YAML2JSON_BIN /usr/local/bin/yaml2json

RUN \
  apk add --update \
    bash \
    curl \
    jq \
    py-pip \
    py-yaml && \
  apk add --update \
    --virtual build-dependencies \
    openssl && \
  pip install -U docker-compose==${COMPOSE_VERSION} && \
  wget "$YAML2JSON_URL/$YAML2JSON_VERSION/$YAML2JSON_PATH" \
    -O "$YAML2JSON_BIN" && \
  chmod +x "$YAML2JSON_BIN" && \
  apk del build-dependencies && \
  rm /var/cache/apk/* && \
  rm -rf `find / -regex '.*\.py[co]' -or -name apk`

COPY config /usr/local/bin/config
COPY bin /usr/local/bin
COPY VERSION /usr/local/bin

ENTRYPOINT ["nib"]
CMD ["--help"]
