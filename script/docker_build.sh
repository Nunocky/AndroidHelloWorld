#!/bin/bash

docker build -t android_build_test \
       ./docker

docker volume create android_build_android_home
docker volume create android_build_gradle_home

