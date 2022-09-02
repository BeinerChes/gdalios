#!/usr/bin/env bash

echo Build libtiff 
cd $SRC

if [ ! -e tiff-$TIFF_VERSION ]
then
echo Downloading libtiff
curl -L -O "https://download.osgeo.org/libtiff/tiff-$TIFF_VERSION.tar.gz"
tar -xzf tiff-$TIFF_VERSION.tar.gz
fi

cd tiff-$TIFF_VERSION
rm -r build_$OS;
mkdir build_$OS;
cd build_$OS

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DPLATFORM=OS64 \
    -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_APPS=OFF \
..
cmake --build . --config Release
cmake --install . --config Release # Necessary to build combined library

cd $SCRIPTS
