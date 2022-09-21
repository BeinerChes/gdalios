#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e gdal-$GDAL_VERSION ]
then
curl -L -O "https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz"
tar -xzf gdal-$GDAL_VERSION.tar.gz
fi
cd $SCRIPTS