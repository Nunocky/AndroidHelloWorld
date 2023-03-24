#!/bin/bash

if [ $# -lt 1 ]; then
  OPTION_IT="-it"
else
  OPTION_IT=""
fi

# TODO /opt/android-sdk-linux が空になってしまう ...?

docker container run --rm "$OPTION_IT" \
  --name android_build_1 \
  -v $(pwd)/docker_volume_android_sdk:/opt/android-sdk-linux \
  -v $(pwd)/docker_volume_gradle:/home/android/.gradle \
  -v $(pwd):/tmp/project \
  -w /tmp/project \
  -e TZ="Asia/Tokyo" \
  android_build \
  ${@:1}

# -v <host_path>:<container_path>
