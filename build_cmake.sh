#!/bin/bash

rm -rf build
mkdir build

docker run --pull always -ti --rm -v `pwd`/sample:/project/source -v `pwd`/build:/project/build -e BUILD_TYPE registry.qdel.fr/rholk/images:latest || exit 1

./run_webserver.sh
