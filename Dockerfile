FROM ruby

ENV COMPOSE_VERSION 1.10.0

RUN \
  gem install rainbow -v '2.2.1' && \
  curl -fsSL https://get.docker.com/ | sh && \
  curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

WORKDIR /usr/src/app

COPY Gemfile* ./
COPY VERSION ./VERSION
COPY lib/nib/version.rb ./lib/nib/version.rb
COPY nib.gemspec ./nib.gemspec

RUN \
  gem install bundler && \
  bundle install -j4

COPY . .

CMD rspec spec
