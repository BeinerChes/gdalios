#!/usr/bin/env bash
set -e

export SCRIPTS=$( pwd; )
export DEV=$HOME/dev

open $DEV

export SRC=$HOME/dev/src
export INSTALL=$HOME/dev/install
export CMTOOLCHAIN=$DEV/ios.toolchain.cmake

#check https://proj.org/download.html for Current Release
export PROJ_VERSION=9.1.0
export GDAL_VERSION=3.5.1
export GEOS_VERSION=3.11.0
export TIFF_VERSION=4.4.0


if [ ! -e $DEV ] 
then
    echo mkdir $DEV
    mkdir $DEV
fi

open $DEV

if [ ! -e $SRC ] 
then
    echo mkdir $SRC
    mkdir $SRC
fi

if [ ! -e $INSTALL ] 
then
    echo mkdir $INSTALL
    mkdir $INSTALL
fi

if [ ! -e $PREFIX ] 
then
    echo mkdir $PREFIX
    mkdir $PREFIX
fi

if [ ! -f "$CMTOOLCHAIN" ]; then
    curl -L -o $CMTOOLCHAIN https://raw.githubusercontent.com/BeinerChes/ios-cmake/master/ios.toolchain.cmake    
fi

#echo Installing Homebrew package manager
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#echo Installing CMAKE
#brew install cmake
#brew install llvm --HEAD

#git --version
#echo Installing SQLite

. build_sqlite.sh
exit
#. build_sqlite.sh SIMULATOR64 2>> output_SIMULATOR64.log &
wait
#echo Installing libtiff
#. build_libtiff.sh OS64
#brew install libtiff
. build_proj.sh OS64 2>> output_OS64.log &
. build_proj.sh SIMULATOR64 2>> output_SIMULATOR64.log &
wait
. build_gdal.sh OS64 2>> output_OS64.log &
. build_gdal.sh SIMULATOR64 2>> output_SIMULATOR64.log &
wait

