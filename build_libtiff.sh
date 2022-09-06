#!/usr/bin/env bash

OS=$1
PREFIX=$INSTALL/$OS

cd $SRC

if [ ! -e $SRC/tiff-$TIFF_VERSION ]
then
echo Downloading libtiff
curl -L -O "https://download.osgeo.org/libtiff/tiff-$TIFF_VERSION.tar.gz"
tar -xzf tiff-$TIFF_VERSION.tar.gz
fi

cd tiff-$TIFF_VERSION
if [ -d build_$OS ] 
then
    rm -r build_$OS;
fi 

mkdir build_$OS;
cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..

cmake --build .
#cmake --build . --target install

cd $SCRIPTS
