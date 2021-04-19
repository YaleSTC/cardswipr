FROM ruby:2.6.5-alpine

# Install packages
RUN apk update && \
  apk upgrade

RUN apk add --update --no-cache postgresql-dev yarn nodejs tzdata bash
RUN apk add --no-cache --virtual .build-deps \
  build-base git

COPY Gemfile* /usr/src/app/
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install --without development test
RUN yarn install --production

RUN apk del .build-deps

COPY . /usr/src/app/

RUN RAILS_ENV=production rails assets:precompile

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
