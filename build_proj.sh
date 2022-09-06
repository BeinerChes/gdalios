#!/usr/bin/env bash

OS=$1
PREFIX=$INSTALL/$OS

cd $SRC

if [ ! -e proj-$PROJ_VERSION ]
then
echo Downloading proj
curl -L -O "https://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz"
tar -xzf proj-$PROJ_VERSION.tar.gz
fi

cd proj-$PROJ_VERSION
if [ -d build_$OS ] 
then
rm -r build_$OS;
fi
mkdir build_$OS;
cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DENABLE_TIFF=ON \
    -DTIFF_INCLUDE_DIR=/opt/homebrew/Cellar/libtiff/4.4.0_1/include \
    -DTIFF_LIBRARY_RELEASE=/opt/homebrew/Cellar/libtiff/4.4.0_1/lib/libtiff.a \
    -DENABLE_CURL=OFF \
    -DBUILD_PROJSYNC=OFF \
    -DBUILD_TESTING=OFF \
    -DBUILD_APPS=OFF \
    -DSQLITE3_INCLUDE_DIR=$PREFIX/include \
    -DSQLITE3_LIBRARY=$PREFIX/lib/libsqlite3.a \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build .
cmake --build . --target install

cd $SCRIPTS
