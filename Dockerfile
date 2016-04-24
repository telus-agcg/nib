FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive
ENV COMPOSE_VERSION 1.7.0

RUN apt-get update -q && \
  apt-get install -y -q --no-install-recommends curl ca-certificates jq git ssh && \
  curl -o /usr/local/bin/docker-compose -L \
    "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64" && \
  chmod +x /usr/local/bin/docker-compose && \
  rm -rf \
    # Clean up any temporary files:
    /tmp/* \
    # Clean up the pip cache:
    /root/.cache \
    # Clean up the cache:
    /var/lib/apt/lists/* \
    /tmp/* /var/tmp/* \
    # Remove any compiled python files (compile on demand):
    `find / -regex '.*\.py[co]'`

RUN mkdir -p /bin

COPY bin /usr/local/bin

ENTRYPOINT ["nib"]
CMD ["--help"]
