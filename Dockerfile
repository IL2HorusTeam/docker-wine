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
    wget \
    telnet \
    cabextract \
    winehq-staging \
 && rm -rf /var/lib/apt/lists/*

ENV WINEARCH="win32"
ENV WINEPREFIX="/root/.wine32"

RUN mkdir -p $WINEPREFIX \
 && cd $WINEPREFIX \
 && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
 && chmod +x winetricks \
 && wine wineboot --init \
 && sh ./winetricks d3dx9 corefonts
