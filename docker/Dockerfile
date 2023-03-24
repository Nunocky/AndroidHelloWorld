FROM androidsdk/android-31

# このコンテナには androidというユーザーが登録済み
ARG username="android"

RUN chown -R $username:$username /opt/android-sdk-linux

# ここから先はユーザー $username に切り替えて作業
USER $username
RUN mkdir -p /home/$username/.gradle

RUN yes | sdkmanager --sdk_root=/opt/android-sdk-linux --licenses >/dev/null

CMD /bin/bash -i

VOLUME ["/opt/android-sdk-linux", "/home/$username/.gradle"]
