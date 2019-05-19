FROM trzeci/emscripten AS qtbuilder

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
# Build Qt for WASM
RUN mkdir -p /development/qt5_build
WORKDIR /development/qt5_build
RUN /development/qt5/configure -xplatform wasm-emscripten -static -nomake examples -nomake tests -opensource --confirm-license
RUN make -j `grep -c '^processor' /proc/cpuinfo`
RUN make install


FROM trzeci/emscripten

# install GE root certificate
# must be downloaded from https://static.gecirtnotification.com/browser_remediation/sop_server_v1.html and copied into container first
# Copy the current directory contents into the container
WORKDIR /development
COPY GE_External_Root_CA_2_1.crt /development
RUN cp GE_External_Root_CA_2_1.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates

# Copy Qt binaries to new container
COPY --from=qtbuilder /usr/local/Qt-5.13.0/ /usr/local/Qt-5.13.0/
ENV PATH="/usr/local/Qt-5.13.0/bin:${PATH}"

# Install Boost & Eigen
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# Activate backports to get more recent version of Boost
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update && apt-get -y install \
    libeigen3-dev && \
    apt-get -t stretch-backports -y install libboost1.67-dev   # https://packages.debian.org/stretch/libboost-dev
# Make symlinks to avoid adding /usr/include to include dirs.
RUN mkdir /project && mkdir /project/dependencies && \
    ln -s /usr/include/boost  /project/dependencies/boost && \
    ln -s /usr/include/eigen3 /project/dependencies/eigen3

# Build custom sources
WORKDIR /project/build

# Run build script
CMD unix/build_wasm.sh Release
