#!/usr/bin/env bash
set -e

export SCRIPTS=$( pwd; )
export DEV=$HOME/dev

export SRC=$HOME/dev/src
export INSTALL=$HOME/dev/install
export CMTOOLCHAIN=$DEV/ios.toolchain.cmake

export PROJ_VERSION=9.1.0
export GDAL_VERSION=3.5.1

. prepare.sh

#. build_sqlite.sh OS64
#. build_sqlite.sh SIMULATOR64
#. build_sqlite.sh SIMULATORARM64
#. frame_sqlite.sh

#. build_proj.sh OS64
#. build_proj.sh SIMULATOR64
#. build_proj.sh SIMULATORARM64
#. frame_proj.sh

export SDKPATH=$(xcrun --sdk iphoneos --show-sdk-path)
. build_gdal.sh OS64
export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
. build_gdal.sh SIMULATOR64
export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
. build_gdal.sh SIMULATORARM64
. frame_proj.sh
. frame_gdal.sh


cd $SCRIPTS
