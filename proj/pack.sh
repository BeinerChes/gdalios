#!/usr/bin/env bash
if [ -d $DEV/framework/proj ] 
then 
    rm -r $DEV/framework/proj
fi

mkdir -p    $DEV/framework/proj/ios-arm64/library \
            $DEV/framework/proj/ios-arm64/headers \
            $DEV/framework/proj/ios-x86_64-arm64-simulator/library \
            $DEV/framework/proj/ios-x86_64-arm64-simulator/headers \

  
cp -r $INSTALL/proj/OS64/include/* $DEV/framework/proj/ios-arm64/headers    
cp -r $INSTALL/proj/SIMULATOR64/include/* $DEV/framework/proj/ios-x86_64-arm64-simulator/headers

cp $SCRIPTS/proj/module.modulemap $DEV/framework/proj/ios-arm64/Headers/module.modulemap
cp $SCRIPTS/proj/module.modulemap $DEV/framework/proj/ios-x86_64-arm64-simulator/Headers/module.modulemap

libtool -static -o \
    $INSTALL/proj/OS64/lib/libproj_linked.a \
    $INSTALL/proj/OS64/lib/libproj.a \
    $INSTALL/sqlite/OS64/lib/libsqlite3.a \
    $INSTALL/jpeg/OS64/lib/libjpeg.a \
    $INSTALL/tiff/OS64/lib/libtiff.a \

libtool -static -o \
    $INSTALL/proj/SIMULATOR64/lib/libproj_linked.a \
    $INSTALL/proj/SIMULATOR64/lib/libproj.a \
    $INSTALL/sqlite/SIMULATOR64/lib/libsqlite3.a \
    $INSTALL/jpeg/SIMULATOR64/lib/libjpeg.a \
    $INSTALL/tiff/SIMULATOR64/lib/libtiff.a \

libtool -static -o \
    $INSTALL/proj/SIMULATORARM64/lib/libproj_linked.a \
    $INSTALL/proj/SIMULATORARM64/lib/libproj.a \
    $INSTALL/sqlite/SIMULATORARM64/lib/libsqlite3.a \
    $INSTALL/jpeg/SIMULATORARM64/lib/libjpeg.a \
    $INSTALL/tiff/SIMULATORARM64/lib/libtiff.a \

cp -i $INSTALL/proj/OS64/lib/libproj_linked.a $DEV/framework/proj/ios-arm64/library/libproj.a
lipo -create -output $DEV/framework/proj/ios-x86_64-arm64-simulator/library/libproj.a \
    $INSTALL/proj/SIMULATORARM64/lib/libproj_linked.a \
    $INSTALL/proj/SIMULATOR64/lib/libproj_linked.a \

xcodebuild -create-xcframework \
-library $DEV/framework/proj/ios-arm64/library/libproj.a \
-headers $DEV/framework/proj/ios-arm64/headers \
-library $DEV/framework/proj/ios-x86_64-arm64-simulator/library/libproj.a \
-headers $DEV/framework/proj/ios-x86_64-arm64-simulator/headers \
-output  $DEV/framework/proj/libproj.xcframework