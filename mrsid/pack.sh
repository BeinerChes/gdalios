#!/usr/bin/env bash

mkdir -p    $DEV/framework/mrsid/ios-arm64/library \
            $DEV/framework/mrsid/ios-arm64/headers \
            $DEV/framework/mrsid/ios-x86_64-arm64-simulator/library \
            $DEV/framework/mrsid/ios-x86_64-arm64-simulator/headers \

  
cp -r $INSTALL/mrsid/Raster_DSDK/include/* $DEV/framework/mrsid/ios-arm64/headers    
cp -r $INSTALL/mrsid/Raster_DSDK/include/* $DEV/framework/mrsid/ios-x86_64-arm64-simulator/headers

cp -i $INSTALL/mrsid/Raster_DSDK/lib/OS64/libltidsdk.a $DEV/framework/mrsid/ios-arm64/library/libltidsdk.a
lipo -create -output $DEV/framework/mrsid/ios-x86_64-arm64-simulator/library/libltidsdk.a \
    $INSTALL/mrsid/Raster_DSDK/lib/SIMULATORARM64/libltidsdk.a \
    $INSTALL/mrsid/Raster_DSDK/lib/SIMULATOR64/libltidsdk.a \

xcodebuild -create-xcframework \
-library $DEV/framework/mrsid/ios-arm64/library/libltidsdk.a \
-headers $DEV/framework/mrsid/ios-arm64/headers \
-library $DEV/framework/mrsid/ios-x86_64-arm64-simulator/library/libltidsdk.a \
-headers $DEV/framework/mrsid/ios-x86_64-arm64-simulator/headers \
-output  $DEV/framework/mrsid/mrsid.xcframework