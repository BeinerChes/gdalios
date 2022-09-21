#!/usr/bin/env bash
OS=$1
PREFIX=$INSTALL/geos/$OS

cd $SRC
cd geos-$GEOS_VERSION
if [ -d build_$OS ] 
then
rm -r build_$OS
fi
mkdir build_$OS
cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DDEPLOYMENT_TARGET=$DEPLOYMENT_TARGET \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_GEOSOP=OFF \
    -DBUILD_TESTING=OFF \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS