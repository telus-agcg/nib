FROM cimg/ruby:3.1

WORKDIR /usr/src/app

COPY . .

RUN \
  mkdir -p /usr/src/app/.bundle/config && \
  bundle install -j4

ENTRYPOINT []

CMD rake rspec:unit
