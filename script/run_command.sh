#!/bin/bash

WORK_DIR=`pwd`
#USERNAME=$(id -un)
USERNAME="builder"

if [ $# -lt 1 ];then
   OPTION_IT="-it"
else
   OPTION_IT=""
fi


docker container run --rm  $OPTION_IT \
       --name android_build_1 \
       -v ${WORK_DIR}:${WORK_DIR} \
       -w ${WORK_DIR} \
       -e ANDROID_HOME="/home/${USERNAME}/Android" \
       -e TZ="Asia/Tokyo" \
       -v `pwd`/Android:/home/${USERNAME}/Android \
       -v `pwd`/gradle:/home/${USERNAME}/.gradle \
       android_build_test \
       ${@:1}

# -v <host_path>:<container_path>


# ホスト上のディレクトリを使用
#       -v `pwd`/Android:/home/${USERNAME}/Android \
#       -v `pwd`/gradle:/home/${USERNAME}/.gradle \


# volumeを使うとロックファイルの取得に失敗する
#       -v android_build_android_home:/home/${USERNAME}/Android \
#       -v android_build_gradle:/home/${USERNAME}/gradle \
