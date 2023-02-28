#!/bin/bash

rm -rf build
mkdir build

docker run -ti --rm -v `pwd`/sample:/project/source -v `pwd`/build:/project/build qdel/qtwasm bash -c "/usr/local/Qt-wasm/bin/qt-cmake -DCMAKE_BUILD_TYPE=Release -G Ninja /project/source && ninja -v" || exit 1
