#!/usr/bin/env bash

rm -f tmp/pids/server.pid &&
exec bundle exec rails server
