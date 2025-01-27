FROM ruby:3.3.0

WORKDIR /usr/src/app

COPY . .

RUN bundle install -j5
