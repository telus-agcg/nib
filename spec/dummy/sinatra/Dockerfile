FROM ruby:alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install -j4

COPY . /usr/src/app

EXPOSE 4567

CMD ["ruby", "app.rb"]

