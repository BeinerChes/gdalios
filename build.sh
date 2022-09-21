#!/usr/bin/env bash
set -e

export SCRIPTS=$( pwd; )
export DEV=$HOME/dev/gdal_ios
export SRC=$DEV/src
export INSTALL=$DEV/install

export DEPLOYMENT_TARGET='14.0'

export CMTOOLCHAIN=$SCRIPTS/ios.toolchain.cmake

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

. sqlite/download.sh
export SDKPATH=$(xcrun --sdk iphoneos --show-sdk-path)
. sqlite/build.sh OS64
export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
. sqlite/build.sh SIMULATOR64
. sqlite/build.sh SIMULATORARM64

open $DEV