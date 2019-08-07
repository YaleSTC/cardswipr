#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# variables
secret_file=/run/secrets/deco.json
 
# process deco file
deco validate $secret_file || exit 1
deco run $secret_file

# source the new environment variables
set -a
. ./.env
set +a

rails db:migrate RAILS_ENV=$RAILS_ENV

exec "$@"