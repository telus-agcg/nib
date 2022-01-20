FROM cimg/ruby:3.1

WORKDIR /usr/src/app

COPY . .

RUN \
  bundle install -j4

ENTRYPOINT []

CMD rake rspec:unit
