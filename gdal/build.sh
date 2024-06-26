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
    -DJPEG_ROOT=$INSTALL/jpeg/$OS \
    -DGEOTIFF_INCLUDE_DIR=$INSTALL/geotiff/$OS/include \
    -DGEOTIFF_LIBRARY_RELEASE=$INSTALL/geotiff/$OS/lib/libgeotiff.a \
    -DTIFF_INCLUDE_DIR=$INSTALL/tiff/$OS/include \
    -DTIFF_LIBRARY_RELEASE=$INSTALL/tiff/$OS/lib/libtiff.a \
    -DWebP_ROOT=$INSTALL/webp/$OS \
    -DGDAL_USE_ZSTD=OFF \
    -DOpenJPEG_ROOT=$INSTALL/open_jpeg/$OS \
    ..

#ccmake .
#return 0
cmake --build . --config Release --target install

cd $SCRIPTS