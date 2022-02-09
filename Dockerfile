FROM ruby:3.0-alpine

WORKDIR /usr/src/app

COPY . .

RUN \
  bundle install -j4
