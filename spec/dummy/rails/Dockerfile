FROM ruby:2.3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4

COPY . /usr/src/app

EXPOSE 3000

CMD ["rackup", "-p", "3000", "-o", "0.0.0.0"]
