FROM alpine:3.5

ARG DOCKER_VERSION=1.13.1
ARG COMPOSE_VERSION=1.11.2

WORKDIR /usr/src/app

COPY . .

RUN \
  # install dev dependencies
  apk --no-cache add \
    bash \
    build-base \
    git \
    libffi-dev \
    py-pip \
    python \
    ruby \
    ruby-bundler \
    ruby-dev \
    wget && \

  # install docker
  mkdir /code && \
  cd /code && \
  wget \
    --no-check-certificate \
    -qO- \
    https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz \
    | tar xvz && \
  mv docker/docker /usr/local/bin && \

  # install docker-compose
  git \
    clone \
    --branch ${COMPOSE_VERSION} \
    https://github.com/docker/compose.git \
    /code/compose && \
  cd /code/compose && \
  pip \
    --no-cache-dir install \
    -r requirements.txt \
    -r requirements-dev.txt \
    pyinstaller==3.1.1 && \
  git rev-parse --short HEAD > compose/GITSHA && \
  ln -s /lib /lib64 && \
  ln -s /lib/libc.musl-x86_64.so.1 ldd && \
  ln -s /lib/ld-musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 && \
  pyinstaller docker-compose.spec && \
  unlink /lib/ld-linux-x86-64.so.2 /lib64 ldd || true && \
  mv dist/docker-compose /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose && \

  # install ruby dependencies
  bundle install --gemfile=/usr/src/app/Gemfile --clean -j4 && \

  # cleanup
  pip freeze | xargs pip uninstall -y && \

  apk del \
    bash \
    build-base \
    ca-certificates \
    git \
    libffi-dev \
    py-pip \
    python \
    ruby-dev && \

  rm -rf /code /usr/lib/python2.7/ /root/.cache /var/cache/apk/* && \
  rm -rf /usr/lib/ruby/gems/*/cache/* && \
  rm -rf /var/cache/apk/* /tmp

CMD rake rspec:unit
