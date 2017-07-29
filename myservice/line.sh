#!/bin/sh

if [ -z "${SERVICE_URL}" ]; then
  echo "env SERVICE_URL is not defined."
  exit 1
fi

TEXT=$1
TO=${2-$LINE_TO_DEFAULT}

if [ -z "${TO}" ]; then
  echo "usage: $0 <text> <to>"
  exit 1
fi

curl -X POST -H "Accept: application/json" -H "Content-type: application/json" "${SERVICE_URL}" -d @- <<EOT
{
  "service_method": "line_push",
  "to": "${TO}",
  "text": "${TEXT}"
}
EOT