FROM ruby:3.2-alpine

WORKDIR /usr/src/app

COPY . .

RUN \
  bundle install -j5
