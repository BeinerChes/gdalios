#!/usr/bin/env bash
set -e

export SCRIPTS=$( pwd; )
export DEV=$HOME/dev/gdal_ios
export SRC=$DEV/src
export INSTALL=$DEV/install

export DEPLOYMENT_TARGET='14.0'

export CMTOOLCHAIN=$SCRIPTS/ios.toolchain.cmake

export CURL_VERSION=7.85.0              
export LIBJPEG_TURBO_VERSION=2.1.4
export TIFF_VERSION=4.4.0
export PROJ_VERSION=9.1.0
export GEOS_VERSION=3.11.0
export GDAL_VERSION=3.5.2
export OPENJPEG_VERSION=2.5.0
export KML_VERSION=1.3.0
export WEBP_VERSION=1.2.4


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

. sqlite/download.sh &
. jpeg/download.sh &
. tiff/download.sh &
. curl/download.sh &
. proj/download.sh &
. geos/download.sh &
. open_jpeg/download.sh &
. kml/download.sh &
. openssl/download.sh &
. webp/download.sh &
. gdal/download.sh &
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
#. kml/build.sh OS64
#. webp/build.sh OS64
. gdal/build.sh OS64
exit 0
export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
. sqlite/build.sh SIMULATOR64
. jpeg/build.sh SIMULATOR64
. tiff/build.sh SIMULATOR64
. proj/build.sh SIMULATOR64
. geos/build.sh SIMULATOR64
. gdal/build.sh SIMULATOR64

. sqlite/build.sh SIMULATORARM64
. jpeg/build.sh SIMULATORARM64
. tiff/build.sh SIMULATORARM64
. proj/build.sh SIMULATORARM64
. geos/build.sh SIMULATORARM64
. gdal/build.sh SIMULATORARM64

. gdal/pack.sh