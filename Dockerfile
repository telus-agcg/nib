FROM docker/compose:1.26.0

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
  bundle install --gemfile=/usr/src/app/Gemfile --clean --force -j4

ENTRYPOINT []

CMD rake rspec:unit
