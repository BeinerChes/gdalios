#!/usr/bin/env bash
set -e

echo GDAL
export SCRIPTS=$( pwd; )
export DEV=$HOME/dev

export SRC=$HOME/dev/src
export INSTALL=$HOME/dev/install
export CMTOOLCHAIN=$DEV/ios.toolchain.cmake

#check https://proj.org/download.html for Current Release
export PROJ_VERSION=9.0.1
#https://gdal.org/download.html#current-release
export GDAL_VERSION=3.5.1
export GEOS_VERSION=3.11.0
export TIFF_VERSION=4.4.0


if [ ! -d $DEV ] 
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

if [ ! -f "$CMTOOLCHAIN" ]; then
    curl -L -o $CMTOOLCHAIN https://raw.githubusercontent.com/BeinerChes/ios-cmake/master/ios.toolchain.cmake    
fi

echo GDAL
#. build_libtiff.sh OS64
#. build_libtiff.sh SIMULATOR64

#return 0
#echo Installing Homebrew package manager
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#. build_geos.sh OS64
#echo Installing CMAKE
#brew install cmake
#brew install llvm --HEAD

#git --version
#echo Installing SQLite


. build_sqlite.sh OS64 2> output_sqlite_OS64.log 
#. build_sqlite.sh SIMULATOR64 2> output_sqlite_SIMULATOR64.log 

#wait
#. build_libtiff.sh OS64 2> output_libtiff_SIMULATOR64.log 
#. build_libtiff.sh SIMULATOR64 2> output_libtiff_SIMULATOR64.log 
#. build_libtiff.sh SIMULATORARM64 2>> output_libtiff_SIMULATOR64.log &
#wait
#brew install libtiff
#. build_proj.sh OS64 2> output_proj_OS64_proj.log 
#exit
. build_proj.sh SIMULATOR64 2> output_proj_SIMULATOR64_proj.log 
exit
#. build_proj.sh SIMULATORARM64 2>> output_proj_SIMULATORARM64_proj.log &
#wait
#. build_geos.sh OS64 2> output_geos_OS64.log
#. build_geos.sh SIMULATOR64 2> output_geos_SIMULATOR64.log
#. build_geos.sh SIMULATORARM64 2>> output_geos_SIMULATORARM64.log &
#wait

#. build_gdal.sh OS64 2> output_gdal_SIMULATOR64.log
#. build_gdal.sh SIMULATOR64 2> output_gdal_SIMULATOR64.log 
#. build_gdal.sh SIMULATORARM64 2>> output_gdal_SIMULATORARM64.log &
#alpwait


#exit


if [ ! -d $INSTALL/Combined ] 
then
mkdir -p $INSTALL/Combined
fi

lipo -create -output $INSTALL/Combined/libproj.a \
    $INSTALL/proj/OS64/lib/libproj.a \
    $INSTALL/proj/SIMULATOR64/lib/libproj.a \



if [ ! -d $INSTALL/Framework ] 
then
mkdir $INSTALL/Framework
fi

if [ -e $INSTALL/Framework/libsqlite3.xcframework ] 
then 
rm -rf $INSTALL/Framework/libsqlite3.xcframework
fi

cp $SCRIPTS/libsqlite3_modulemap/module.modulemap $INSTALL/sqlite/OS64/include/
cp $SCRIPTS/libsqlite3_modulemap/module.modulemap $INSTALL/sqlite/SIMULATOR64/include/

xcodebuild -create-xcframework \
-library $INSTALL/sqlite/OS64/lib/libsqlite3.a \
-headers $INSTALL/sqlite/OS64/include/ \
-library $INSTALL/sqlite/SIMULATOR64/lib/libsqlite3.a \
-headers $INSTALL/sqlite/SIMULATOR64/include/ \
-output $INSTALL/Framework/libsqlite3.xcframework

if [ -e $INSTALL/Framework/libproj.xcframework ] 
then 
rm -rf $INSTALL/Framework/libproj.xcframework
fi

cp $SCRIPTS/libproj_modulemap/module.modulemap $INSTALL/proj/OS64/include/
cp $SCRIPTS/libproj_modulemap/module.modulemap $INSTALL/proj/SIMULATOR64/include/

xcodebuild -create-xcframework \
-library $INSTALL/proj/OS64/lib/libproj.a \
-headers $INSTALL/proj/OS64/include/ \
-library $INSTALL/proj/SIMULATOR64/lib/libproj.a \
-headers $INSTALL/proj/SIMULATOR64/include/ \
-output $INSTALL/Framework/libproj.xcframework

#xcodebuild -create-xcframework \
#-library $INSTALL/OS64/lib/libsqlite3.a \
#-headers $INSTALL/OS64/include/ \
#-library $INSTALL/SIMULATOR64/lib/libsqlite3.a \
#-headers $INSTALL/SIMULATOR64/include/ \
#-output $INSTALL/Framework/sqlite3.xcframework

#xcodebuild -create-xcframework \
#-library $INSTALL/OS64/lib/libproj.a \
#-headers $INSTALL/OS64/include/ \
#-library $INSTALL/SIMULATOR64/lib/libproj.a \
#-headers $INSTALL/SIMULATOR64/include/ \
#-output $INSTALL/Framework/proj.xcframework

#cd $SCRIPTS

