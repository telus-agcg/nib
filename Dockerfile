FROM docker/compose:1.19.0

WORKDIR /usr/src/app

COPY . .

RUN \
  apk --no-cache add --virtual .rundeps \
    bash \
    build-base \
    curl \
    docker \
    git \
    libffi-dev \
    ruby \
    ruby-bundler \
    ruby-dev \
    ruby-json

RUN \
  bundle install --gemfile=/usr/src/app/Gemfile --clean -j4

ENTRYPOINT []

CMD rake rspec:unit
