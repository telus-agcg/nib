FROM ruby:alpine

ENV COMPOSE_VERSION 1.7.1

RUN \
  apk add --update \
    py-pip \
    py-yaml && \
  pip install -U docker-compose==${COMPOSE_VERSION} && \
  rm /var/cache/apk/* && \
  rm -rf `find / -regex '.*\.py[co]' -or -name apk`

WORKDIR /usr/src/app

COPY Gemfile* /usr/src/app/
COPY lib/nib/version.rb /usr/src/app/lib/nib/version.rb
COPY nib.gemspec /usr/src/app

RUN \
  gem install bundler && \
  bundle install -j4

COPY . /usr/src/app

ENTRYPOINT ["nib"]
CMD ["--help"]
