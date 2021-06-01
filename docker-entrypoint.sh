#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

RAILS_ENV=$RAILS_ENV bundle exec rails db:create && bundle exec rails db:migrate

exec "$@"