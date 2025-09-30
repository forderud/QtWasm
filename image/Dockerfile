# Based on https://github.com/emscripten-core/emsdk/tree/master/docker
# The Emscripten version must match the Qt version as documented on https://doc.qt.io/qt-6/wasm.html and https://doc-snapshots.qt.io/qt6-dev/wasm.html
FROM emscripten/emsdk:3.1.70 AS emscripten_base

FROM emscripten_base AS qtbuilder

# Extra Qt build parameters
ARG EXTRA_BUILD_PARAMS=

# Qt 6.5 show warnings if default locale is not UTF-8
ENV LANG=C.UTF-8

RUN mkdir -p /development

# Install GEHC root certificates
# Ubuntu steps:
COPY gehealthcarerootca1.crt gehealthcarerootca2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
# RedHat/Fedora steps:
#COPY gehealthcarerootca1.crt gehealthcarerootca2.crt /etc/pki/ca-trust/source/anchors
#RUN update-ca-trust

# Install Mesa OpenGL and ninja (needed to build Qt for x64)
RUN apt-get update && apt-get -y install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev ninja-build

# Clone Qt sources
WORKDIR /development
RUN git clone --branch v6.9.3 https://code.qt.io/qt/qt5.git
WORKDIR /development/qt5
RUN git rev-parse HEAD
RUN ./init-repository

# Build Qt for x64
RUN mkdir -p /development/qt5_build_x64
WORKDIR /development/qt5_build_x64
RUN /development/qt5/configure -nomake examples -nomake tests -prefix /usr/local/Qt-x64
RUN cmake --build . $EXTRA_BUILD_PARAMS
RUN cmake --install .

# Build Qt for WASM
RUN mkdir -p /development/qt5_build
WORKDIR /development/qt5_build
RUN /development/qt5/configure -qt-host-path /usr/local/Qt-x64 -xplatform wasm-emscripten -feature-wasm-simd128 -feature-wasm-exceptions -feature-thread -nomake examples -prefix /opt/Qt
RUN cmake --build . $EXTRA_BUILD_PARAMS
RUN cmake --install .

# Build HDF5 for WASM
COPY customtoolchainflags.cmake /
WORKDIR /build
RUN git clone --branch hdf5_1.14.6 https://github.com/HDFGroup/hdf5.git
WORKDIR /build/hdf5

# Apply custom patch(es)
COPY *.patch /build/hdf5/
RUN git apply "0001-Only-clear-FE_INVALID-when-that-symbol-is-present-on.patch" # https://github.com/HDFGroup/hdf5/pull/4954

#inject wasm specific flags in the projects
RUN emcmake cmake -S . -B build-wasm -DCMAKE_INSTALL_PREFIX:PATH=/opt/wasm-deps \
    -DHDF5_INSTALL_CMAKE_DIR=lib/cmake/ \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DBUILD_SHARED_LIBS:BOOL=OFF \
    -DBUILD_TESTING:BOOL=OFF \
    -DHDF5_ENABLE_Z_LIB_SUPPORT:BOOL=OFF \
    -DHDF5_BUILD_CPP_LIB:BOOL=ON \
    -DHDF5_BUILD_EXAMPLES:BOOL=OFF \
    -DCMAKE_TOOLCHAIN_FILE=/customtoolchainflags.cmake
WORKDIR /build/hdf5/build-wasm
RUN emmake make -j`nproc` install


# Eigen 3.4.0 does not support sse optimizations, but the tip of 3.4 does
# use a self-built version of the eigen package from 3.4 branch
# rollback to deb packages when 3.4.1 is released and available
FROM emscripten_base AS eigen

# Install GEHC root certificates
# Ubuntu steps:
COPY gehealthcarerootca1.crt gehealthcarerootca2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
# RedHat/Fedora steps:
#COPY gehealthcarerootca1.crt gehealthcarerootca2.crt /etc/pki/ca-trust/source/anchors
#RUN update-ca-trust

RUN git clone --branch 3.4 https://gitlab.com/libeigen/eigen.git && \
    cd eigen && \
    emcmake cmake -S . -B build-wasm -DCMAKE_INSTALL_PREFIX:PATH=/opt/wasm-deps/ -DCMAKE_BUILD_TYPE:STRING=Release && \
    cd build-wasm && \
    emmake make -j`nproc` install


FROM emscripten_base

# Install GEHC root certificates
# Ubuntu steps:
COPY gehealthcarerootca1.crt gehealthcarerootca2.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
# RedHat/Fedora steps:
#COPY gehealthcarerootca1.crt gehealthcarerootca2.crt /etc/pki/ca-trust/source/anchors
#RUN update-ca-trust

# Copy binaries to new container
COPY --from=qtbuilder /usr/local/Qt-x64/ /usr/local/Qt-x64/
COPY --from=qtbuilder /opt/Qt/           /opt/Qt/
COPY --from=qtbuilder /opt/wasm-deps/    /opt/wasm-deps/

# Use self-installed eigen
COPY --from=eigen /opt/wasm-deps/include/eigen3/    /opt/wasm-deps/include/eigen3/
COPY --from=eigen /opt/wasm-deps/share/eigen3/    /opt/wasm-deps/share/eigen3/
COPY --from=eigen /opt/wasm-deps/share/pkgconfig/eigen3.pc /opt/wasm-deps/share/pkgconfig/eigen3.pc

# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
RUN apt-get update && apt-get -y install \
    ninja-build      \
    libtool-bin      \
    libboost-dev

# Make symlinks to avoid adding /usr/include to include dirs.
RUN mkdir -p /opt/wasm-deps/include && mkdir -p /opt/wasm-deps/lib && mkdir -p /opt/wasm-deps/share && \
    ln -s /usr/include/boost   /opt/wasm-deps/include/boost  && \
    ln -s /usr/lib/cmake       /opt/wasm-deps/lib/cmake

# Add qmake to PATH (doesn't seem to work)
#ENV PATH="/opt/Qt/bin:${PATH}"

# Build custom sources
WORKDIR /project/build

# Default build command will explicitly target wasm
CMD /opt/Qt/bin/qt-cmake -DCMAKE_BUILD_TYPE=Release -G Ninja /project/source && ninja
