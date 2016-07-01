FROM ruby:alpine

ENV COMPOSE_VERSION 1.7.1

RUN \
  apk add --update \
    py-pip \
    py-yaml && \
  pip install -U docker-compose==${COMPOSE_VERSION} && \
  rm /var/cache/apk/* && \
  rm -rf `find / -regex '.*\.py[co]' -or -name apk`

# RUN gem install nib

# this is not ideal because these files will remain as part of the image,
# we should explore a build pipline that compile the gem first and then leaves
# an artifact to be installed by the next step in the process
COPY . /usr/src/app

RUN \
  cd /usr/src/app && \
  rake build && \
  cp -r pkg /usr/local/pkg && \
  cd /usr/local/pkg && \
  gem install nib* && \
  rm -rf /usr/src/app && \
  rm -rf /usr/local/pkg

ENTRYPOINT ["nib"]
CMD ["--help"]
