#!/bin/sh

if [ -z "${SERVICE_URL}" ]; then
  echo "env SERVICE_URL is not defined."
  exit 1
fi

TEXT=$1

if [ -z "$1" ]; then
  echo "usage: $0 <text>"
  exit 1
fi

curl -X POST -H "Accept: application/json" -H "Content-type: application/json" "${SERVICE_URL}" -d @- <<EOT
{
  "service_method": "line_push",
  "text": "${TEXT}"
}
EOT