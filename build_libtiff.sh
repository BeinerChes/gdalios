#!/usr/bin/env bash
echo Build libtiff 
cd $SRC

if [ ! -e proj-$PROJ_VERSION ]
then
echo Downloading geos
curl -L -O "http://download.osgeo.org/libtiff/tiff-4.4.0.tar.gz"
tar -xzf tiff-4.4.0.tar.gz
fi

cd tiff-4.4.0


cd $SCRIPTS
