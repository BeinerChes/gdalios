#!/usr/bin/env bash

echo Build Proj 
cd $SRC

if [ ! -e proj-$PROJ_VERSION ]
then
echo Downloading proj
curl -O "https://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz"
tar -xzf proj-$PROJ_VERSION.tar.gz
fi

cd proj-$PROJ_VERSION
rm -r build_$OS; mkdir build_$OS; cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DENABLE_TIFF=OFF -DENABLE_CURL=OFF \
    -DBUILD_PROJSYNC=OFF \
    -DSQLITE3_INCLUDE_DIR=$PREFIX/include \
    -DSQLITE3_LIBRARY=$PREFIX/lib/libsqlite3.a \
    ..
cmake --build .
cmake --build . --target install

cd $SCRIPTS
