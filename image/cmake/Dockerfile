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

# Build custom sources
WORKDIR /project/build

# build CMake project (doesn't work yet)
CMD cmake -DCMAKE_TOOLCHAIN_FILE=/emsdk_portable/sdk/cmake/Modules/Platform/Emscripten.cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" -DCMAKE_PREFIX_PATH=/usr/local/Qt-5.13.0 -DQt5_DIR=/usr/local/Qt-5.13.0/lib/cmake/Qt5 -DQt5Qml_DIR=/usr/local/Qt-5.13.0/lib/cmake/Qt5Qml -DQt5Network_DIR=/usr/local/Qt-5.13.0/lib/cmake/Qt5Network -DQt5Core_DIR=/usr/local/Qt-5.13.0/lib/cmake/Qt5Core  -DQt5Quick_DIR=/usr/local/Qt-5.13.0/lib/cmake/Qt5Quick -DQt5Gui_DIR=/usr/local/Qt-5.13.0/lib/cmake/Qt5Gui /project/source && make
