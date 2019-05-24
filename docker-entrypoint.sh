#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

rails db:create && rails db:migrate RAILS_ENV=$RAILS_ENV

exec "$@"