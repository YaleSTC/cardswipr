FROM ruby:2.6.0

# Fix issue with the wrong nodejs being installed - https://stackoverflow.com/questions/52708521/autoprefixer-doesn-t-support-node-v4-8-2-update-it
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    nodejs

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

COPY config/database.yml.docker config/database.yml

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
