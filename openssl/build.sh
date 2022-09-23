#!/bin/sh
OS=$1
PREFIX=$INSTALL/openssl/$OS

cd $SRC/openssl-cmake

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
    -DWITH_APPS=OFF \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS