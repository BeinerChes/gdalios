#!/usr/bin/env bash

mkdir -p $INSTALL/sqlite/iphoneos/lib \
    $INSTALL/sqlite/iphonesimulator/lib \
    $INSTALL/sqlite/iphoneos/Headers \
    $INSTALL/sqlite/iphonesimulator/Headers \

#cp $INSTALL/sqlite/OS64/include/* $INSTALL/sqlite/iphoneos/Headers
#cp $INSTALL/sqlite/SIMULATOR64/include/* $INSTALL/sqlite/iphonesimulator/Headers

#cp $SCRIPTS/sqlite.modulemap $INSTALL/sqlite/iphoneos/Headers/module.modulemap
#cp $SCRIPTS/sqlite.modulemap $INSTALL/sqlite/iphonesimulator/Headers/module.modulemap

lipo -create -output $INSTALL/sqlite/iphoneos/lib/libsqlite3.a \
    $INSTALL/sqlite/OS64/lib/libsqlite3.a
lipo -create -output $INSTALL/sqlite/iphonesimulator/lib/libsqlite3.a \
    $INSTALL/sqlite/SIMULATORARM64/lib/libsqlite3.a \
    $INSTALL/sqlite/SIMULATOR64/lib/libsqlite3.a

if [ -e $INSTALL/Framework/libsqlite3.xcframework ] 
then
    rm -rf $INSTALL/Framework/libsqlite3.xcframework
fi

xcodebuild -create-xcframework \
-library $INSTALL/sqlite/iphoneos/lib/libsqlite3.a \
-library $INSTALL/sqlite/iphonesimulator/lib/libsqlite3.a \
-output $INSTALL/Framework/libsqlite3.xcframework

#xcodebuild -create-xcframework \
#-library $INSTALL/sqlite/iphoneos/lib/libsqlite3.a \
#-headers $INSTALL/sqlite/iphoneos/Headers/ \
#-library $INSTALL/sqlite/iphonesimulator/lib/libsqlite3.a \
#-headers $INSTALL/sqlite/iphonesimulator/Headers/ \
#-output $INSTALL/Framework/libsqlite3.xcframework