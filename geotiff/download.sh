#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e libgeotiff-$GEOTIFF_VERSION ]
then
#https://github.com/OSGeo/libgeotiff/releases/download/1.7.1/libgeotiff-1.7.1.tar.gz
curl -L -O "https://github.com/OSGeo/libgeotiff/releases/download/$GEOTIFF_VERSION/libgeotiff-$GEOTIFF_VERSION.tar.gz"
tar -xzf libgeotiff-$GEOTIFF_VERSION.tar.gz
fi
cd $SCRIPTS