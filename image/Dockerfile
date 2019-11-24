# Based on https://hub.docker.com/r/trzeci/emscripten-upstream
FROM trzeci/emscripten-upstream:1.39.3 AS qtbuilder

RUN mkdir -p /development
WORKDIR /development

# install GE root certificate
# must be downloaded from https://static.gecirtnotification.com/browser_remediation/sop_server_v1.html and copied into container first
# Copy the current directory contents into the container
COPY GE_External_Root_CA_2_1.crt /development
RUN cp GE_External_Root_CA_2_1.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Clone Qt sources
RUN git clone --branch=5.13 https://code.qt.io/qt/qt5.git
WORKDIR /development/qt5
RUN ./init-repository

# Apply custom patch(es)
COPY *.diff /development/qt5/
RUN git apply --directory=qtbase ca9daff.diff # merged to 5.14
RUN git apply --directory=qtbase 31482e1.diff # https://bugreports.qt.io/browse/QTBUG-80286

# Build Qt for WASM
RUN mkdir -p /development/qt5_build
WORKDIR /development/qt5_build
RUN /development/qt5/configure -xplatform wasm-emscripten -static -nomake examples -nomake tests -opensource --confirm-license
RUN make -j `grep -c '^processor' /proc/cpuinfo`
RUN make install


FROM trzeci/emscripten-upstream:1.39.3

# install GE root certificate
# must be downloaded from https://static.gecirtnotification.com/browser_remediation/sop_server_v1.html and copied into container first
# Copy the current directory contents into the container
WORKDIR /development
COPY GE_External_Root_CA_2_1.crt /development
RUN cp GE_External_Root_CA_2_1.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Copy Qt binaries to new container
COPY --from=qtbuilder /usr/local/Qt-5.13.2/ /usr/local/Qt-5.13.2/

# Install Boost & Eigen
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# Activate backports to get more recent version of Boost
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get -y install \
    libeigen3-dev && \
    apt-get -t stretch-backports -y install libboost1.67-dev   # https://packages.debian.org/stretch/libboost-dev
# Make symlinks to avoid adding /usr/include to include dirs.
RUN mkdir -p /project/dependencies/include && mkdir -p /project/dependencies/lib && \
    ln -s /usr/include/boost   /project/dependencies/include/boost  && \
    ln -s /usr/include/eigen3  /project/dependencies/include/eigen3 && \
    ln -s /usr/lib/cmake       /project/dependencies/lib/cmake      && \
    ln -s /usr/local/Qt-5.13.2 /project/Qt                          && \
    ln -s /emsdk_portable      /emsdk_portable/emscripten                 # TODO: Remove after next Emscripten upgrade

# Add qmake to PATH (doesn't seem to work)
#ENV PATH="/usr/local/Qt-5.13.2/bin:${PATH}"

# Build custom sources
WORKDIR /project/build

# Default build command
CMD cmake -DCMAKE_TOOLCHAIN_FILE=/emsdk_portable/emscripten/sdk/cmake/Modules/Platform/Emscripten.cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -DCMAKE_PREFIX_PATH=/usr/local/Qt-5.13.2 /project/source && make
