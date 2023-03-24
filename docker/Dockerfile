FROM openjdk:11-jdk-slim

ARG username="builder"
ARG userid=1000
ARG groupid=1000

# apt-utilsをインストールしなくても警告が表示されないようにする
ENV DEBCONF_NOWARNINGS yes

# sdkmanager を使って現在のマシンとは異なるオペレーティングシステム用
# のパッケージをダウンロードする場合に使います。今回は、
# openjdk:11-jdk-slimがAlpine Linuxなので指定しなくても大丈夫なのです
# が、明示的に指定しておきます。
ENV REPO_OS_OVERRIDE "linux"

# Android Studioの公式サイトを見て最新番号を確認
ENV ANDROID_SDK_TOOLS="9477386"

# ビルド対象の gradleに合わせておく
ENV GRADLE_VERSION="7.5"
ENV ANDROID_BUILD_TOOLS="33.0.0"
# TODO ANDROID_BUILD_TOOLSから "33"を取り出したい
ENV ANDROID_COMPILE_SDK="33"

# 途中の作業で必要になるパッケージをインストールします。
# 少しでも軽くするために不要なパッケージを自動削除します。
# 本当なら最後に、wgetやunzipなども削除すべきです。
RUN apt-get update --quiet --yes
RUN apt-get autoremove --quiet --yes
RUN apt-get install --quiet --yes wget
RUN apt-get install --quiet --yes unzip
RUN rm -rf /var/lib/apt/lists/*

# ユーザーを作成
RUN groupadd -g $groupid $username
RUN useradd -m -u $userid --groups sudo -g $groupid $username 
RUN echo "${username}:${username}" | chpasswd

# 環境変数
ENV HOME="/home/${username}"
ENV ANDROID_HOME="${HOME}/Android"
ENV ANDROID_SDK_ROOT=${ANDROID_HOME}/sdk
ENV GRADLE_HOME="${HOME}/gradle"
ENV GRADLE_CACHE="${HOME}/.gradle"

ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin:${GRADLE_CACHE}/bin


# ここから先はユーザー $username に切り替えて作業
USER $username

RUN mkdir -p ${ANDROID_SDK_ROOT}

# コマンドラインツールのインストール
RUN wget --quiet --output-document=$HOME/android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip
RUN unzip -q -d ${ANDROID_SDK_ROOT}/cmdline-tools $HOME/android-sdk.zip
RUN mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/tools
RUN rm -rf $HOME/android-sdk.zip

# gradleのインストール (TODO 必要?)
RUN mkdir -p ${GRADLE_CACHE}
RUN wget --quiet --output-document=$HOME/gradle-bin.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
RUN unzip -q -d ${HOME}/gradle $HOME/gradle-bin.zip
RUN rm -rf $HOME/gradle-bin.zip

# sdk-toolsの licensesに同意
RUN mkdir ~/.android
RUN touch ~/.android/repositories.cfg

RUN yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses >/dev/null


# 必要なパッケージのインストール
RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" >/dev/null

# ボリュームを公開
# TODO GRADLE_HOMEと GRADLE_CACHEの両方を volume化する必要はある?
VOLUME $ANDROID_HOME
VOLUME $GRADLE_CACHE
VOLUME $GRADLE_HOME

CMD /bin/bash -i
