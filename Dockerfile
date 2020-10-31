FROM i386/debian:buster-slim

LABEL maintainer="Oleksandr Oblovatnyi <oblovatniy@gmail.com>"

ARG WINEARCH="win32"
ARG WINEPREFIX="/root/.wine32"
ARG WINE_VERSION="5.0"

ENV WINEARCH=$WINEARCH
ENV WINEPREFIX=$WINEPREFIX
ENV WINE_VERSION=$WINE_VERSION

RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    telnet \
    cabextract \
    gnupg2 \
    wget \
 && mkdir -p $WINEPREFIX \
 && cd $WINEPREFIX \
 && wget https://dl.winehq.org/wine-builds/winehq.key -O - | apt-key add - \
 && echo "deb https://dl.winehq.org/wine-builds/debian buster main" > /etc/apt/sources.list.d/winehq.list \
 && wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key -O - | apt-key add - \
 && echo "deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10 ./" > /etc/apt/sources.list.d/obs.list \
 && { \
	   echo "Package: *wine* *wine*:i386"; \
		echo "Pin: version $WINE_VERSION~buster"; \
		echo "Pin-Priority: 1001"; \
  } > /etc/apt/preferences.d/winehq.pref \
 && apt-get update \
 && apt-get install -y --no-install-recommends winehq-stable \
 && wine wineboot --init \
 && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks \
 && chmod +x winetricks \
 && sh ./winetricks d3dx9 corefonts \
 && apt purge --auto-remove -y \
   software-properties-common \
   gnupg2 \
   wget \
 && apt autoremove --purge -y \
 && rm -rf /var/lib/apt/lists/*
