#!/bin/sh
set -e

OS=$1
PREFIX=$INSTALL/geotiff/$OS

cd $SRC
cd libgeotiff-$GEOTIFF_VERSION

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
    -DPROJ_INCLUDE_DIR=$INSTALL/proj/$OS/include \
    -DPROJ_LIBRARY=$INSTALL/proj/$OS/lib/libproj.a \
    -DTIFF_INCLUDE_DIR=$INSTALL/tiff/$OS/include \
    -DTIFF_LIBRARY_RELEASE=$INSTALL/tiff/$OS/lib/libtiff.a \
    -DWITH_UTILITIES=FALSE \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS
