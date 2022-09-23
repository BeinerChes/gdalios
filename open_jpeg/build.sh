#!/bin/sh
OS=$1
PREFIX=$INSTALL/open_jpeg/$OS

cd $SRC/openjpeg-$OPENJPEG_VERSION

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
    -DBUILD_CODEC=OFF \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS