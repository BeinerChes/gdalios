#!/usr/bin/env bash

mkdir -p $INSTALL/gdal/iphoneos/lib \
    $INSTALL/gdal/iphonesimulator/lib \
    $INSTALL/gdal/iphoneos/Headers \
    $INSTALL/gdal/iphonesimulator/Headers \

cp -r $INSTALL/gdal/OS64/include/* $INSTALL/gdal/iphoneos/Headers 
cp -r $INSTALL/gdal/SIMULATOR64/include/* $INSTALL/gdal/iphonesimulator/Headers

cp $SCRIPTS/gdal.modulemap $INSTALL/gdal/iphoneos/Headers/module.modulemap
cp $SCRIPTS/gdal.modulemap $INSTALL/gdal/iphonesimulator/Headers/module.modulemap

lipo -create -output $INSTALL/gdal/iphoneos/lib/libgdal.a \
    $INSTALL/gdal/OS64/lib/libgdal.a


lipo -create -output $INSTALL/gdal/iphonesimulator/lib/libgdal.a \
    $INSTALL/gdal/SIMULATORARM64/lib/libgdal.a \
    $INSTALL/gdal/SIMULATOR64/lib/libgdal.a

if [ -e $INSTALL/Framework/libgdal.xcframework ] 
then
    rm -rf $INSTALL/Framework/libgdal.xcframework
fi

xcodebuild -create-xcframework \
-library $INSTALL/gdal/iphoneos/lib/libgdal.a \
-headers $INSTALL/gdal/iphoneos/Headers/ \
-library $INSTALL/gdal/iphonesimulator/lib/libgdal.a \
-headers $INSTALL/gdal/iphonesimulator/Headers/ \
-output $INSTALL/Framework/libgdal.xcframework