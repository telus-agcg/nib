FROM cimg/ruby:3.1

USER root

WORKDIR /usr/src/app

COPY . .

RUN \
  mkdir -p /usr/src/app/.bundle/ && \
  bundle install -j4

ENTRYPOINT []

CMD rake rspec:unit
