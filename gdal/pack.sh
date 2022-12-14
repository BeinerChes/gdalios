#!/usr/bin/env bash
if [ -d $DEV/framework/gdal ] 
then 
    rm -r $DEV/framework/gdal
fi

mkdir -p    $DEV/framework/gdal/ios-arm64/library \
            $DEV/framework/gdal/ios-arm64/headers \
            $DEV/framework/gdal/ios-x86_64-arm64-simulator/library \
            $DEV/framework/gdal/ios-x86_64-arm64-simulator/headers \

  
cp -r $INSTALL/gdal/OS64/include/* $DEV/framework/gdal/ios-arm64/headers    
cp -r $INSTALL/gdal/SIMULATOR64/include/* $DEV/framework/gdal/ios-x86_64-arm64-simulator/headers

cp $SCRIPTS/gdal/module.modulemap $DEV/framework/gdal/ios-arm64/Headers/module.modulemap
cp $SCRIPTS/gdal/module.modulemap $DEV/framework/gdal/ios-x86_64-arm64-simulator/Headers/module.modulemap




libtool -static -o \
    $INSTALL/gdal/OS64/lib/libgdal_linked.a \
    $INSTALL/gdal/OS64/lib/libgdal.a \
    $INSTALL/proj/OS64/lib/libproj.a \
    $INSTALL/sqlite/OS64/lib/libsqlite3.a \
    $INSTALL/jpeg/OS64/lib/libjpeg.a \
    $INSTALL/tiff/OS64/lib/libtiff.a \
    $INSTALL/geos/OS64/lib/libgeos_c.a \
    $INSTALL/geos/OS64/lib/libgeos.a \

libtool -static -o \
    $INSTALL/gdal/SIMULATOR64/lib/libgdal_linked.a \
    $INSTALL/gdal/SIMULATOR64/lib/libgdal.a \
    $INSTALL/proj/SIMULATOR64/lib/libproj.a \
    $INSTALL/sqlite/SIMULATOR64/lib/libsqlite3.a \
    $INSTALL/jpeg/SIMULATOR64/lib/libjpeg.a \
    $INSTALL/tiff/SIMULATOR64/lib/libtiff.a \
    $INSTALL/geos/SIMULATOR64/lib/libgeos_c.a \
    $INSTALL/geos/SIMULATOR64/lib/libgeos.a \

libtool -static -o \
    $INSTALL/gdal/SIMULATORARM64/lib/libgdal_linked.a \
    $INSTALL/gdal/SIMULATORARM64/lib/libgdal.a \
    $INSTALL/proj/SIMULATORARM64/lib/libproj.a \
    $INSTALL/sqlite/SIMULATORARM64/lib/libsqlite3.a \
    $INSTALL/jpeg/SIMULATORARM64/lib/libjpeg.a \
    $INSTALL/tiff/SIMULATORARM64/lib/libtiff.a \
    $INSTALL/geos/SIMULATORARM64/lib/libgeos_c.a \
    $INSTALL/geos/SIMULATORARM64/lib/libgeos.a \

cp -i $INSTALL/gdal/OS64/lib/libgdal_linked.a $DEV/framework/gdal/ios-arm64/library/libgdal.a
lipo -create -output $DEV/framework/gdal/ios-x86_64-arm64-simulator/library/libgdal.a \
    $INSTALL/gdal/SIMULATORARM64/lib/libgdal_linked.a \
    $INSTALL/gdal/SIMULATOR64/lib/libgdal_linked.a \

xcodebuild -create-xcframework \
-library $DEV/framework/gdal/ios-arm64/library/libgdal.a \
-headers $DEV/framework/gdal/ios-arm64/headers \
-library $DEV/framework/gdal/ios-x86_64-arm64-simulator/library/libgdal.a \
-headers $DEV/framework/gdal/ios-x86_64-arm64-simulator/headers \
-output  $DEV/framework/gdal/libgdal.xcframework