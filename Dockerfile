FROM ubuntu:14.04

RUN apt-get -y update && \
    apt-get install -yq apt-transport-https \
                        ca-certificates \
                        curl \
                        sudo
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get -y update && \
    apt-get install -y nodejs
# RUN npm install -g npm See https://github.com/npm/npm/issues/15558
RUN npm install -g grunt-cli
RUN apt-get -y update && \
    apt-get install --force-yes -yq \
    wget \
    build-essential \
    libcurl4-gnutls-dev \
    libglib2.0-dev \
    libgdk-pixbuf2.0-dev \
    libgtkglext1-dev \
    libatk1.0-dev \
    libcairo2-dev \
    libxml2-dev \
    libxss-dev \
    libgconf2-dev \
    default-jre \
    qt5-qmake \
    qt5-default  \
    p7zip-full \
    git \
    subversion
RUN git clone --recursive https://github.com/ONLYOFFICE/DesktopEditors.git
WORKDIR DesktopEditors
RUN git submodule foreach --recursive git checkout develop
RUN cd core/Common/3dParty && \
    ./make.sh
RUN cd core && \
    make
RUN cd sdkjs && \
    make
# Same workaround as https://github.com/npm/npm/issues/15558 for npm install
RUN cd sdkjs && \
    rm -rf build/node_modules && \ 
    npm install findup-sync resolve nopt grunt-known-options -g && \ 
    bash build/build-desktop.sh
RUN mkdir -pv core/build/cef/linux && \
    cp -r core/Common/3dParty/cef/linux_64/build/* core/build/cef/linux && \
    mkdir -pv core/Common/3dParty/cef/linux && \
    cp -r core/Common/3dParty/cef/linux_64/build/* core/Common/3dParty/cef/linux
RUN cd desktop-sdk/ChromiumBasedEditors/lib && \
    qmake AscDocumentsCore_linux.pro    
RUN apt-get install -y libqt5x11extras5-dev libqt5svg5-dev && \
    cd desktop-apps/win-linux && \
    qmake ASCDocumentEditor.pro
