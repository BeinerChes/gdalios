#!/usr/bin/env bash

mkdir -p $INSTALL/proj/iphoneos/lib \
    $INSTALL/proj/iphonesimulator/lib \
#    $INSTALL/proj/iphoneos/Headers \
#    $INSTALL/proj/iphonesimulator/Headers \

#Proj headers
#cp -r $INSTALL/proj/OS64/include/* $INSTALL/proj/iphoneos/Headers 
#cp -r $INSTALL/proj/SIMULATOR64/include/* $INSTALL/proj/iphonesimulator/Headers
#Sqlite headers
#cp $INSTALL/sqlite/OS64/include/* $INSTALL/proj/iphoneos/Headers 
#cp $INSTALL/sqlite/SIMULATOR64/include/* $INSTALL/proj/iphonesimulator/Headers



#cp $SCRIPTS/proj.modulemap $INSTALL/proj/iphoneos/Headers/module.modulemap
#cp $SCRIPTS/proj.modulemap $INSTALL/proj/iphonesimulator/Headers/module.modulemap

lipo -create -output $INSTALL/proj/iphoneos/lib/libproj.a \
    $INSTALL/proj/OS64/lib/libproj.a


lipo -create -output $INSTALL/proj/iphonesimulator/lib/libproj.a \
    $INSTALL/proj/SIMULATORARM64/lib/libproj.a \
    $INSTALL/proj/SIMULATOR64/lib/libproj.a

if [ -e $INSTALL/Framework/libproj.xcframework ] 
then
    rm -rf $INSTALL/Framework/libproj.xcframework
fi

xcodebuild -create-xcframework \
-library $INSTALL/proj/iphoneos/lib/libproj.a \
-library $INSTALL/proj/iphonesimulator/lib/libproj.a \
-output $INSTALL/Framework/libproj.xcframework