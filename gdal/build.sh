#!/bin/sh
OS=$1
PREFIX=$INSTALL/gdal/$OS

cd $SRC/gdal-$GDAL_VERSION

if [ -d build_$OS ] 
then
rm -r build_$OS
fi
mkdir build_$OS
cd build_$OS

#https://gdal.org/build_hints.html
cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DDEPLOYMENT_TARGET=$DEPLOYMENT_TARGET \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_APPS=OFF \
    -DBUILD_PYTHON_BINDINGS=OFF \
    -DBUILD_TESTING=OFF \
    -DPROJ_ROOT=$INSTALL/proj/$OS \
    -DGEOS_ROOT=$INSTALL/geos/$OS \
    -DTIFF_ROOT=$INSTALL/tiff/$OS \
    -DJPEG_ROOT=$INSTALL/jpeg/$OS \
    -DCURL_ROOT=$INSTALL/curl/$OS \
    -DWebP_ROOT=$INSTALL/webp/$OS \
    -DOpenJPEG_ROOT=$INSTALL/open_jpeg/$OS \
    -DLIBKML_INCLUDE_DIR=$INSTALL/kml/$OS/include \
    -DLIBKML_BASE_LIBRARY=$INSTALL/kml/$OS/lib/libkmlbase.a \
    -DLIBKML_DOM_LIBRARY=$INSTALL/kml/$OS/lib/libkmldom.a \
    -DLIBKML_ENGINE_LIBRARY=$INSTALL/kml/$OS/lib/libkmlengine.a \
    ..
return 0
cmake --build . --config Release --target install

cd $SCRIPTS