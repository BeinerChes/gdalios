#!/usr/bin/env bash

export SCRIPTS=$( pwd; )
export DEV=$HOME/dev
export SRC=$HOME/dev/src
export INSTALL=$HOME/dev/install
export CMTOOLCHAIN=$DEV/ios.toolchain.cmake

#check https://proj.org/download.html for Current Release
export PROJ_VERSION=9.1.0
export GDAL_VERSION=3.5.1
export GEOS_VERSION=3.11.0
export TIFF_VERSION=4.4.0

# for iOS arm64 device
#export SDKPATH=$(xcrun --sdk iphoneos --show-sdk-path)
export OS=OS64COMBINED
export PREFIX=$INSTALL/$OS

# for iOS x86_64 simulator
#export PREFIX=$HOME/build/iphonesimulator_x86_64
#export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
#export OS=SIMULATOR64

# for iOS arm64 simulator
#export PREFIX=$HOME/build/iphonesimulator_arm64
#export SDKPATH=$(xcrun --sdk iphonesimulator --show-sdk-path)
#export OS=SIMULATORARM64

# for Mac Catalyst x86_64
#export PREFIX=$HOME/build/macos_x86_64
#export SDKPATH=$(xcrun --sdk macosx --show-sdk-path)
#export OS=MAC_CATALYST

# for Mac Catalyst arm64
#export PREFIX=$HOME/build/macos_arm64
#export SDKPATH=$(xcrun --sdk macosx --show-sdk-path)
#export OS=MAC_CATALYST_ARM64

if [ ! -e $DEV ] 
then
    echo mkdir $DEV
    mkdir $DEV
fi

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

echo Downloading toolchain
curl -L -o $CMTOOLCHAIN https://raw.githubusercontent.com/BeinerChes/ios-cmake/master/ios.toolchain.cmake

#echo Installing Homebrew package manager
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#echo Installing CMAKE
#brew install cmake
#brew install llvm --HEAD

#git --version

#. build_sqlite.sh
#. build_libtiff.sh
#brew install libtiff
#. build_proj.sh
#  build_geos.sh
. build_gdal.sh
#. build_gdal.sh OS64 &
#wait