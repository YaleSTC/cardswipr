FROM ruby:2.6.0-alpine

# Install packages
RUN apk update && \
  apk upgrade

RUN apk add --update --no-cache postgresql-dev nodejs tzdata
RUN apk add --no-cache --virtual .build-deps \
  build-base git

# Install Deco
ARG DECO_VERSION=0.3.1
ARG DECO_OS=linux
ARG DECO_ARCH=amd64
ADD https://github.com/YaleUniversity/deco/releases/download/v${DECO_VERSION}/deco-v${DECO_VERSION}-${DECO_OS}-${DECO_ARCH} /usr/local/bin/deco
RUN chmod 555 /usr/local/bin/deco && deco version

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

RUN apk del .build-deps

COPY . /usr/src/app/

COPY config/database.yml.docker config/database.yml

COPY .env.prod .env

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
