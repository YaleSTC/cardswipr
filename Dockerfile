# Stage 1: Set up a base for the next stages
FROM ruby:2.6.5-alpine AS base

RUN apk update \
  && apk upgrade \
  && apk add --update --no-cache bash postgresql-dev tzdata

WORKDIR /app

ENV RAILS_ENV=production \
    BUNDLE_PATH=vendor/bundle \
    BUNDLE_WITHOUT=development:test


# Stage 2: Install rails dependencies
FROM base AS build

RUN apk add --no-cache build-base

# Install gems
COPY Gemfile* ./
RUN bundle install --jobs $(nproc)


# Stage 3: Precompile assets
FROM base AS precompile

RUN apk add --no-cache nodejs yarn

# Install javascript dependencies
COPY package.json yarn.lock ./
RUN yarn install --production --check-files

# Copy over the gems installed from the previous stage
COPY --from=build /app/vendor ./vendor
COPY . ./
RUN bundle exec rails assets:precompile


# Stage 4: Take prebuilt assets and run in a fresh alpine container
FROM base AS app

# Create a new unprivileged user named ruby and run as ruby rather than root
RUN adduser ruby --disabled-password
USER ruby

# Copy artifacts from previous stages
COPY --chown=ruby:ruby --from=build /app/vendor ./vendor
COPY --chown=ruby:ruby --from=precompile /app/public ./public
COPY --chown=ruby:ruby . ./

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bundle", "exec", "rails", "s"]
