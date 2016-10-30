FROM ubuntu:16.04

MAINTAINER Alexander Oblovatniy <oblovatniy@gmail.com>

RUN dpkg --add-architecture i386

RUN apt-get update \
 && apt-get install -y \
    software-properties-common \
    python-software-properties \
    telnet

RUN add-apt-repository ppa:wine/wine-builds

RUN apt-get update \
 && apt-get install -y --install-recommends \
    winehq-staging \
 && rm -rf /var/lib/apt/lists/*

RUN wine wineboot --init
