#!/usr/bin/env bash
set -e

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
#export OS=OS64COMBINED


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

#echo Downloading toolchain
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
#. build_sqlite.sh OS64 2>> $DEV/output.txt
#. build_sqlite.sh SIMULATOR64 2>> $DEV/output.txt
#. build_sqlite.sh SIMULATORARM64 2>> $DEV/output.txt
#echo Installing libtiff
#. build_libtiff.sh OS64
#brew install libtiff
#. build_proj.sh OS64 2>> $DEV/output.txt
#. build_proj.sh SIMULATOR64 2>> $DEV/output.txt
#. build_proj.sh SIMULATORARM64 2>> $DEV/output.txt
#  build_geos.sh
#. build_gdal.sh OS64 2>> $DEV/output.txt
#. build_gdal.sh SIMULATOR64 2>> $DEV/output.txt
#. build_gdal.sh SIMULATORARM64 2>> $DEV/output.txt
#wait

#open $DEV/output.txt

#mkdir -p $DEV/build/
#lipo -create -output $DEV/build/libgdal.a \
#    $INSTALL/OS64/lib/libgdal.a \
#    $INSTALL/SIMULATOR64/lib/libgdal.a \
    
xcodebuild -create-xcframework \
-library $INSTALL/OS64/lib/libgdal.a \
-headers $INSTALL/OS64/include/ \
-output $DEV/build/OS64/libgdal.xcframework

xcodebuild -create-xcframework \
-library $INSTALL/SIMULATORARM64/lib/libgdal.a \
-headers $INSTALL/SIMULATORARM64/include/ \
-output $DEV/build/SIMULATORARM64/libgdal.xcframework

#lipo -create -output $HOME/build/iphoneos/lib/libsqlite3.a $HOME/build/iphoneos_arm64/lib/libsqlite3.a
#lipo -create -output $HOME/build/iphonesimulator/lib/libsqlite3.a $HOME/build/iphonesimulator_arm64/lib/libsqlite3.a $HOME/build/iphonesimulator_x86_64/lib/libsqlite3.a
#lipo -create -output $HOME/build/macos/lib/libsqlite3.a $HOME/build/macos_arm64/lib/libsqlite3.a $HOME/build/

#lipo -create -output $HOME/build/iphoneos/lib/libproj.a $HOME/build/iphoneos_arm64/lib/libproj.a
#lipo -create -output $HOME/build/iphonesimulator/lib/libproj.a $HOME/build/iphonesimulator_arm64/lib/libproj.a $HOME/build/iphonesimulator_x86_64/lib/libproj.a
#lipo -create -output $HOME/build/macos/lib/libproj.a $HOME/build/macos_arm64/lib/libproj.a $HOME/build/macos_x86_64/lib/libproj.a

#lipo -create -output $HOME/build/iphoneos/lib/libgdal.a $HOME/build/iphoneos_arm64/lib/libgdal.a
#lipo -create -output $HOME/build/iphonesimulator/lib/libgdal.a $HOME/build/iphonesimulator_arm64/lib/libgdal.a $HOME/build/iphonesimulator_x86_64/lib/libgdal.a
#lipo -create -output $HOME/build/macos/lib/libgdal.a $HOME/build/macos_arm64/lib/libgdal.a $HOME/build/macos_x86_64/lib/libgdal.a