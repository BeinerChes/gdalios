#!/usr/bin/env bash

echo Build geos 
cd $SRC

if [ ! -e proj-$PROJ_VERSION ]
then
echo Downloading geos
curl -L -O "https://github.com/libgeos/geos/releases/download/$GEOS_VERSION/geos-$GEOS_VERSION.tar.bz2"
tar -xzf geos-$GEOS_VERSION.tar.bz2
fi

cd geos-$GEOS_VERSION
rm -r build_$OS; mkdir build_$OS; cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build .
cmake --build . --target install

cd $SCRIPTS
