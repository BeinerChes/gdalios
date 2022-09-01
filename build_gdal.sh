#!/usr/bin/env bash

echo Build Proj 
cd $SRC

if [ ! -e gdal-$PROJ_VERSION ]
then
echo Downloading gdal
curl -L -O "https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz"
tar -xzf gdal-$GDAL_VERSION.tar.gz
fi

if [  $GDAL_VERSION = 3.5.1 ]
then
echo Downloading cmake patch
curl -L "https://raw.githubusercontent.com/BeinerChes/gdaliospatch/main/PATCH_configure.cmake" -o $SRC/PATCH_configure.cmake
patch gdal-$GDAL_VERSION/cmake/helpers/configure.cmake $SRC/PATCH_configure.cmake
fi

cd gdal-$GDAL_VERSION
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

