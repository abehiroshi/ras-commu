#!/bin/sh

if [ -z "${GOOGLE_API_KEY}" ]; then
  echo "env GOOGLE_API_KEY is not defined"
  exit 1
fi

IMAGE_FILE=$1

if [ ! -f "${IMAGE_FILE}" ]; then
  echo "usage: $0 <image file>"
  exit 1
fi

curl -X POST -H "Content-Type: application/json" https://vision.googleapis.com/v1/images:annotate?key=${GOOGLE_API_KEY} -d @- <<EOT
{
  "requests": [
    {
      "image": {
        "content": "$(base64 ${IMAGE_FILE})"
      },
      "features": [
        {
          "type": "TEXT_DETECTION"
        }
      ],
      "imageContext": {
        "languageHints": [
          "ja"
        ]
      }
    }
  ]
}
EOT
