FROM ruby:2.6.0-alpine

# Install packages
RUN apk update && \
  apk upgrade

RUN apk add --update --no-cache postgresql-dev nodejs tzdata
RUN apk add --no-cache --virtual .build-deps \
  build-base git

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

RUN apk del .build-deps

COPY . /usr/src/app/

COPY config/database.yml.prod config/database.yml

EXPOSE 80

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0", "-p", "80"]
