FROM ruby:2.6.5-alpine AS build

RUN apk update \
   && apk upgrade \
   && apk add --update --no-cache alpine-sdk nodejs postgresql-dev tzdata yarn

WORKDIR /app

COPY Gemfile* ./
RUN bundle install --path vendor/bundle --without development test --jobs $(nproc)

COPY package.json ./
COPY yarn.lock ./
RUN yarn install --production --check-files

COPY . ./
RUN RAILS_ENV=production bundle exec rails assets:precompile


FROM ruby:2.6.5-alpine AS app

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache postgresql-dev tzdata

WORKDIR /app

COPY --from=build /app .

# Tell bundle where we installed the gems and not to look for dev or test gems
RUN bundle config --local path vendor/bundle
RUN bundle config --local without development:test

COPY . ./

RUN adduser ruby --disabled-password
USER ruby

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bundle", "exec", "rails", "s"]
