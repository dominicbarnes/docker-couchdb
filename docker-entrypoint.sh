#!/usr/bin/env bash

set -e

# determine the base URL for couchdb (admin party is assumed, unless a
# username + password is provided via env vars)
if [ ! -z $COUCHDB_USER ]; then
  COUCHDB="http://$COUCHDB_USER:$COUCHDB_PASSWORD@localhost:5984"
else
  COUCHDB="http://localhost:5984"
fi

# this will ensure that the entire tree of processes will be stopped after the
# parent exits.
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# run the entrypoint script that is included by the base image to start the
# server (all arguments will be passed along, see the base image documentation)
echo "Starting CouchDB..."
exec "/docker-entrypoint.sh" "$@" &

# wait for couchdb to be online
while ! nc -z localhost 5984; do
  sleep 0.1
done

# once the database is available, bootstrap the server
echo "Running couchdb-bootstrap..."
couchdb-bootstrap "$COUCHDB" /docker-entrypoint-init.d

# this is used with the "trap" above to wait for something to kill the script
wait
