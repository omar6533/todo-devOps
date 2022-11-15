FROM ubuntu:20.04

# ENV DEBIAN_FRONTEND=noninteractive
# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Set up user as root
RUN mkdir /home/flutterdev
WORKDIR /home/flutterdev
USER root

# Prepare Android directories and system variables
# RUN mkdir -p Android/sdk
# ENV ANDROID_SDK_ROOT /home/flutterdev/Android/sdk
# RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
# RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
# RUN unzip sdk-tools.zip && rm sdk-tools.zip
# RUN mv tools Android/sdk/tools
# RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
# RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
# ENV PATH "$PATH:/home/ flutterdev /Android/sdk/platform-tools"

# Download Flutter SDK
#RUN git clone https://github.com/flutter/flutter.git
# RUN git clone --branch stable https://github.com/flutter/flutter.git
# ENV PATH "$PATH:/home/flutterdev/flutter/bin"

# Run basic check to download Dart SDK
RUN flutter doctor
RUN flutter config --no-analytics