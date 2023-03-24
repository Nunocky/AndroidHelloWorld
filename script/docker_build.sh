#!/bin/bash

docker build -t android_build_test \
  ./docker

docker volume create android_home
docker volume create gradle_cache
#docker volume create gradle_home

#docker volume create android_build_android_home
#docker volume create android_build_gradle_home

#  --build-arg userid=$(id -u) \
#  --build-arg groupid=$(id -g) \
#  --build-arg username=$(id -un) \
#
