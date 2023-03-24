#!/bin/bash

# TODO まだここまでこれてない

# 環境変数は run_command.shに書きたい
export ANDROID_HOME="/home/builder/Android"

export PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin
export PATH=$PATH:$GRADLE_HOME/bin

export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
#echo "sdk.dir=/home/builder/Android/sdk" >./local.properties

sdkmanager --sdk_root="$ANDROID_HOME" --licenses

./gradlew :app:assembleDebug

exit 0
