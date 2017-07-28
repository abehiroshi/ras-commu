#!/bin/sh

LOCAL_FILEPATH=$1
DROPBOX_FILEPATH=$2

if [ ! -f "${LOCAL_FILEPATH}" -o -z "${DROPBOX_FILEPATH}" ]; then
  echo "usage: $0 <filepath> <dropbox path>"
  exit 1
fi

curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization: Bearer " \
    --header "Dropbox-API-Arg: {\"path\": \"${DROPBOX_FILEPATH}\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @${LOCAL_FILEPATH}
