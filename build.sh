#!/usr/bin/env bash
set -e

export SCRIPTS=$( pwd; )
export DEV=$HOME/Documents/gdal_ios
export SRC=$DEV/src
export INSTALL=$DEV/install

export DEPLOYMENT_TARGET='15.0'

export CMTOOLCHAIN=$SCRIPTS/ios.toolchain.cmake
       
export LIBJPEG_TURBO_VERSION=2.1.4
export TIFF_VERSION=4.4.0
export PROJ_VERSION=9.1.1
export GEOS_VERSION=3.11.0
export GDAL_VERSION=3.6.2
export OPENJPEG_VERSION=2.5.0
export KML_VERSION=1.3.0
export WEBP_VERSION=1.2.4
export GEOTIFF_VERSION=1.7.1

if [ ! -d $DEV ] 
then
    mkdir -p $DEV
fi

if [ ! -d $SRC ] 
then
    mkdir -p $SRC
fi

if [ ! -d $INSTALL ] 
then
    mkdir -p $INSTALL
fi

if [ ! -f "$CMTOOLCHAIN" ]; then
    curl -L -o $CMTOOLCHAIN https://raw.githubusercontent.com/BeinerChes/ios-cmake/master/ios.toolchain.cmake    
fi
open $DEV
#. openssl/download.sh &
#. curl/download.sh &
#. sqlite/download.sh &
#. jpeg/download.sh &
#. tiff/download.sh &
#. proj/download.sh &
#. geos/download.sh &
#. open_jpeg/download.sh &
#. webp/download.sh &
#. mrsid/download.sh &
#. geotiff/download.sh &
#. gdal/download.sh &
wait
export SDKPATH=$(xcrun --sdk iphoneos --show-sdk-path)
#. openssl/build.sh OS64
#. curl/build.sh OS64
#. sqlite/build.sh OS64
#. jpeg/build.sh OS64 
#. tiff/build.sh OS64 
#. proj/build.sh OS64
#. geos/build.sh OS64
#. open_jpeg/build.sh OS64
#. webp/build.sh OS64
#. geotiff/build.sh OS64 
. gdal/build.sh OS64
export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
#. openssl/build.sh SIMULATOR64
#. curl/build.sh SIMULATOR64
#. sqlite/build.sh SIMULATOR64
#. jpeg/build.sh SIMULATOR64 
#. tiff/build.sh SIMULATOR64 
#. proj/build.sh SIMULATOR64
#. geos/build.sh SIMULATOR64
#. open_jpeg/build.sh SIMULATOR64
#. webp/build.sh SIMULATOR64
#. geotiff/build.sh SIMULATOR64 
#. gdal/build.sh SIMULATOR64

#. openssl/build.sh SIMULATORARM64
#. curl/build.sh SIMULATORARM64
#. sqlite/build.sh SIMULATORARM64
#. jpeg/build.sh SIMULATORARM64 
#. tiff/build.sh SIMULATORARM64 
#. proj/build.sh SIMULATORARM64
#. geos/build.sh SIMULATORARM64
#. open_jpeg/build.sh SIMULATORARM64
#. webp/build.sh SIMULATORARM64
#. geotiff/build.sh SIMULATORARM64 
#. gdal/build.sh SIMULATORARM64

#. gdal/pack.sh