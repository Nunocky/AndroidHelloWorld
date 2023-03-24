#!/bin/bash

#WORK_DIR=`pwd`
#USERNAME=$(id -un)
USERNAME="builder"

if [ $# -lt 1 ]; then
  OPTION_IT="-it"
else
  OPTION_IT=""
fi

docker container run --rm $OPTION_IT \
  --name android_build_1 \
  -v android_home:/home/${USERNAME}/Android \
  -v gradle_cache:/home/${USERNAME}/.gradle \
  -v gradle_home:/home/${USERNAME}/gradle \
  -v $(pwd):/tmp/project \
  -w /tmp/project \
  -e ANDROID_HOME="/home/${USERNAME}/Android" \
  -e TZ="Asia/Tokyo" \
  android_build_test \
  ${@:1}

# -v <host_path>:<container_path>

# ホスト上のディレクトリを使用
#       -v `pwd`/Android:/home/${USERNAME}/Android \
#       -v `pwd`/gradle:/home/${USERNAME}/.gradle \

# volumeを使うとロックファイルの取得に失敗する
#       -v android_build_android_home:/home/${USERNAME}/Android \
#       -v android_build_gradle:/home/${USERNAME}/gradle \

#  -v android_home:/home/${USERNAME}/Android \
#  -v build_cache:/home/${USERNAME}/.gradle \

#  -v $(pwd)/docker_volume_Android:/home/${USERNAME}/Android \
#  -v $(pwd)/docker_volume_gradle_cache:/home/${USERNAME}/.gradle \
