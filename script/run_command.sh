#!/bin/bash

if [ $# -lt 1 ]; then
  OPTION_IT="-it"
else
  OPTION_IT=""
fi

docker container run --rm "$OPTION_IT" \
  --name android_build_1 \
  -v docker_volume_android_sdk:/opt/android-sdk-linux \
  -v docker_volume_gradle:/home/android/.gradle \
  -v $(pwd):/tmp/project \
  -w /tmp/project \
  -e TZ="Asia/Tokyo" \
  android_build \
  ${@:1}

# -v <host_path>:<container_path>
