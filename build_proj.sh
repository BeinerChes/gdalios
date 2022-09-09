#!/usr/bin/env bash

OS=$1
PREFIX=$INSTALL/proj/$OS

cd $SRC

if [ ! -e proj-$PROJ_VERSION ]
then
curl -L -O "https://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz"
tar -xzf proj-$PROJ_VERSION.tar.gz
fi

cd proj-$PROJ_VERSION
if [ ! -d build_$OS ] 
then
mkdir build_$OS;
fi
cd build_$OS

#https://proj.org/install.html#cmake-configure-options
cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=ON \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_APPS=OFF \
    -DSQLITE3_INCLUDE_DIR=$INSTALL/sqlite/$OS/include \
    -DSQLITE3_LIBRARY=$INSTALL/sqlite/$OS/libsqlite3.a \
    -DENABLE_TIFF=OFF \
    -DENABLE_CURL=OFF \
    -DBUILD_PROJSYNC=OFF \
    -DBUILD_TESTING=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..
  
cmake --build .
cmake --build . --target install

cd $SCRIPTS
