#!/usr/bin/env bash
OS=$1
PREFIX=$INSTALL/tiff/$OS
cd $SRC
if [ ! -e tiff-$TIFF_VERSION ]
then
curl -L -O "https://download.osgeo.org/libtiff/tiff-$TIFF_VERSION.tar.gz"
tar -xzf tiff-$TIFF_VERSION.tar.gz
patch $SRC/tiff-$TIFF_VERSION/libtiff/CMakeLists.txt $SCRIPTS/tiff/PATCH_LIBTIFF_1.cmake
patch $SRC/tiff-$TIFF_VERSION/CMakeLists.txt $SCRIPTS/tiff/PATCH_LIBTIFF_2.cmake
fi

cd $SCRIPTS