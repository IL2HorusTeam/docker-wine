FROM ubuntu:16.04

MAINTAINER Alexander Oblovatniy <oblovatniy@gmail.com>

RUN dpkg --add-architecture i386

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    software-properties-common \
    python-software-properties

RUN add-apt-repository ppa:wine/wine-builds

RUN apt-get update \
 && apt-get install -y --install-recommends \
    telnet \
    winehq-staging \
 && rm -rf /var/lib/apt/lists/*

RUN wine wineboot --init
