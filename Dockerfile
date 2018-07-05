FROM ubuntu:16.04

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
RUN cd DesktopEditors && \
    cd core/Common/3dParty && \
    ./make.sh
# RUN cd DesktopEditors/core/Common/3dParty/boost && \
#     bash fetch.sh && \
#     bash build.sh
# RUN cd DesktopEditors/core/Common/3dParty/cef && \
#     bash fetch.sh && \
#     bash build.sh
# RUN cd DesktopEditors/core/Common/3dParty/curl && \
#     bash fetch.sh
# RUN cd DesktopEditors/core/Common/3dParty/icu && \
#     bash fetch.sh && \
#     bash build.sh
# RUN cd DesktopEditors/core/Common/3dParty/openssl && \
#     bash fetch.sh && \
#     bash build.sh
# RUN cd DesktopEditors/core/Common/3dParty/v8 && \
#     bash fetch.sh
# RUN cd DesktopEditors/core/Common/3dParty/v8 && \
#     bash build.sh    

