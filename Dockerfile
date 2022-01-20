FROM cimg/ruby:3.1

WORKDIR /usr/src/app

COPY . .

RUN \
  bundle install --gemfile=/usr/src/app/Gemfile --clean --force -j4

ENTRYPOINT []

CMD rake rspec:unit
