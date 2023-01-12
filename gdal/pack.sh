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



   lipo -info $INSTALL/gdal/SIMULATOR64/lib/libgdal.a 
   lipo -info $INSTALL/proj/SIMULATOR64/lib/libproj.a 
   lipo -info $INSTALL/sqlite/SIMULATOR64/lib/libsqlite3.a 
   lipo -info $INSTALL/jpeg/SIMULATOR64/lib/libjpeg.a 
   lipo -info $INSTALL/geotiff/SIMULATOR64/lib/libgeotiff.a 
   lipo -info $INSTALL/tiff/SIMULATOR64/lib/libtiff.a 
   lipo -info $INSTALL/geos/SIMULATOR64/lib/libgeos_c.a 
   lipo -info $INSTALL/geos/SIMULATOR64/lib/libgeos.a 
   lipo -info $INSTALL/curl/SIMULATOR64/lib/libcurl.a 
   lipo -info $INSTALL/open_jpeg/SIMULATOR64/lib/libopenjp2.a 
   lipo -info $INSTALL/openssl/SIMULATOR64/lib/libcrypto.a 
   lipo -info $INSTALL/openssl/SIMULATOR64/lib/libssl.a 
   lipo -info $INSTALL/webp/SIMULATOR64/lib/libwebp.a 
   lipo -info $INSTALL/webp/SIMULATOR64/lib/libwebpdecoder.a 
   lipo -info $INSTALL/webp/SIMULATOR64/lib/libwebpdemux.a 



libtool -static -o \
    $INSTALL/gdal/OS64/lib/libgdal_linked.a \
    $INSTALL/gdal/OS64/lib/libgdal.a \
    $INSTALL/proj/OS64/lib/libproj.a \
    $INSTALL/sqlite/OS64/lib/libsqlite3.a \
    $INSTALL/jpeg/OS64/lib/libjpeg.a \
    $INSTALL/geotiff/OS64/lib/libgeotiff.a \
    $INSTALL/tiff/OS64/lib/libtiff.a \
    $INSTALL/geos/OS64/lib/libgeos_c.a \
    $INSTALL/geos/OS64/lib/libgeos.a \
    $INSTALL/curl/OS64/lib/libcurl.a \
    $INSTALL/open_jpeg/OS64/lib/libopenjp2.a \
    $INSTALL/openssl/OS64/lib/libcrypto.a \
    $INSTALL/openssl/OS64/lib/libssl.a \
    $INSTALL/webp/OS64/lib/libwebp.a \
    $INSTALL/webp/OS64/lib/libwebpdecoder.a \
    $INSTALL/webp/OS64/lib/libwebpdemux.a \

libtool -static -o \
    $INSTALL/gdal/SIMULATOR64/lib/libgdal_linked.a \
    $INSTALL/gdal/SIMULATOR64/lib/libgdal.a \
    $INSTALL/proj/SIMULATOR64/lib/libproj.a \
    $INSTALL/sqlite/SIMULATOR64/lib/libsqlite3.a \
    $INSTALL/jpeg/SIMULATOR64/lib/libjpeg.a \
    $INSTALL/geotiff/SIMULATOR64/lib/libgeotiff.a \
    $INSTALL/tiff/SIMULATOR64/lib/libtiff.a \
    $INSTALL/geos/SIMULATOR64/lib/libgeos_c.a \
    $INSTALL/geos/SIMULATOR64/lib/libgeos.a \
    $INSTALL/curl/SIMULATOR64/lib/libcurl.a \
    $INSTALL/open_jpeg/SIMULATOR64/lib/libopenjp2.a \
    $INSTALL/openssl/SIMULATOR64/lib/libcrypto.a \
    $INSTALL/openssl/SIMULATOR64/lib/libssl.a \
    $INSTALL/webp/SIMULATOR64/lib/libwebp.a \
    $INSTALL/webp/SIMULATOR64/lib/libwebpdecoder.a \
    $INSTALL/webp/SIMULATOR64/lib/libwebpdemux.a \

#return 0

libtool -static -o \
    $INSTALL/gdal/SIMULATORARM64/lib/libgdal_linked.a \
    $INSTALL/gdal/SIMULATORARM64/lib/libgdal.a \
    $INSTALL/proj/SIMULATORARM64/lib/libproj.a \
    $INSTALL/sqlite/SIMULATORARM64/lib/libsqlite3.a \
    $INSTALL/jpeg/SIMULATORARM64/lib/libjpeg.a \
    $INSTALL/geotiff/SIMULATORARM64/lib/libgeotiff.a \
    $INSTALL/tiff/SIMULATORARM64/lib/libtiff.a \
    $INSTALL/geos/SIMULATORARM64/lib/libgeos_c.a \
    $INSTALL/geos/SIMULATORARM64/lib/libgeos.a \
    $INSTALL/curl/SIMULATORARM64/lib/libcurl.a \
    $INSTALL/open_jpeg/SIMULATORARM64/lib/libopenjp2.a \
    $INSTALL/openssl/SIMULATORARM64/lib/libcrypto.a \
    $INSTALL/openssl/SIMULATORARM64/lib/libssl.a \
    $INSTALL/webp/SIMULATORARM64/lib/libwebp.a \
    $INSTALL/webp/SIMULATORARM64/lib/libwebpdecoder.a \
    $INSTALL/webp/SIMULATORARM64/lib/libwebpdemux.a \

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