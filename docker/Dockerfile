FROM openjdk:11-jdk-slim

# apt-utilsをインストールしなくても警告が表示されないようにする
ENV DEBCONF_NOWARNINGS yes

# sdkmanager を使って現在のマシンとは異なるオペレーティングシステム用
# のパッケージをダウンロードする場合に使います。今回は、
# openjdk:11-jdk-slimがAlpine Linuxなので指定しなくても大丈夫なのです
# が、明示的に指定しておきます。
ENV REPO_OS_OVERRIDE "linux"

# CLTとgradleのバージョンのデフォルト値
# Android Studioの公式サイトを見て番号を確認
ARG ANDROID_SDK_TOOLS="9477386"

# ビルド対象の gradleに合わせておく
ARG GRADLE_VERSION="7.3.1"


ARG ANDROID_BUILD_TOOLS="33.0.1"


# 途中の作業で必要になるパッケージをインストールします。
# 少しでも軽くするために不要なパッケージを自動削除します。
# 本当なら最後に、wgetやunzipなども削除すべきです。
RUN apt-get update --quiet --yes \
    && apt-get autoremove --quiet --yes \
    && apt-get install --quiet --yes wget \
    && apt-get install --quiet --yes unzip \
    && rm -rf /var/lib/apt/lists/*



# ユーザーを作成
ARG username=builder
ARG userid=1000
ARG groupid=1000

RUN groupadd -g $groupid $username 
RUN useradd -m -u $userid --groups sudo -g $groupid $username 
RUN echo "${username}:$${username}" | chpasswd



# 環境変数
ENV HOME="/home/${username}"
ENV ANDROID_HOME="${HOME}/Android"
ENV ANDROID_SDK_ROOT=${ANDROID_HOME}/sdk
ENV GRADLE_HOME="${HOME}/.gradle"

ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin:${GRADLE_HOME}/bin



RUN mkdir -p ${ANDROID_SDK_ROOT}
RUN chown -R $username:$username $ANDROID_HOME

# ここから先はユーザー $username に切り替えて作業
USER $username

# コマンドラインツールのインストール
RUN wget --quiet --output-document=$HOME/android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip
RUN unzip -q -d ${ANDROID_SDK_ROOT}/cmdline-tools $HOME/android-sdk.zip
RUN mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/tools
RUN rm -rf $HOME/android-sdk.zip

# gradleのインストール
RUN wget --quiet --output-document=$HOME/gradle-bin.zip https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
RUN unzip -q -d ${HOME}/gradle $HOME/gradle-bin.zip
RUN rm -rf $HOME/gradle-bin.zip

# sdk-toolsの licensesに同意
RUN mkdir ~/.android && \
    touch ~/.android/repositories.cfg

RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses >/dev/null


# 必要なパッケージのインストール
#RUN sdkmanager --sdk_root=${ANDROID_HOME} --install emulator >/dev/null
RUN sdkmanager --sdk_root=${ANDROID_HOME} "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null
RUN ANDROID_COMPILE_SDK="${ANDROID_BUILD_TOOLS%%.*}"; \
    sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools" >/dev/null

CMD /bin/bash -i

VOLUME $ANDROID_HOME
VOLUME $GRADLE_HOME
