#!/usr/bin/env sh

set -eu

host="${1:-}"
shift || true

while ! nc -z "$host" "${1:-5432}"; do
  echo "Waiting for $host:${1:-5432}..."
  sleep 2
done
echo "Service $host:${1:-5432} is available."


