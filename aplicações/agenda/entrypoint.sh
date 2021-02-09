#!/bin/bash
set -e

rm -f /crud-simples/tmp/pids/server.pid

exec "$@"
