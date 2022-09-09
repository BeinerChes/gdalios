#!/usr/bin/env bash

OS=$1
PREFIX=$INSTALL/gdal/$OS

cd $SRC


#https://www.extensis.com/support/developers
if [ ! -e MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz ]
then
echo Downloading mrsid
curl -L -O "https://bin.extensis.com/download/developer/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz" 
tar -xzf MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz
fi

if [ ! -e gdal-$GDAL_VERSION ]
then
echo Downloading gdal
echo curl -L -O "https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz"
curl -L -O "https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz"
tar -xzf gdal-$GDAL_VERSION.tar.gz
fi

if [  $GDAL_VERSION = 3.5.1 ]
then
if [  ! -e $SRC/PATCH_configure.cmake ]
then
curl -L "https://raw.githubusercontent.com/BeinerChes/gdalios/main/PATCH_3.5.1_configure.cmake" -o $SRC/PATCH_configure.cmake
patch gdal-$GDAL_VERSION/cmake/helpers/configure.cmake $SRC/PATCH_configure.cmake
fi
fi

cd gdal-$GDAL_VERSION
if [ ! -d build_$OS ] 
then
mkdir build_$OS;
fi
cd build_$OS


#https://gdal.org/build_hints.html
cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_APPS=OFF \
    -DBUILD_PYTHON_BINDINGS=OFF \
    -DPROJ_ROOT=$INSTALL/proj/$OS \
    -DSQLITE3_INCLUDE_DIR=$INSTALL/sqlite/$OS/include \
    -DSQLITE3_LIBRARY=$INSTALL/sqlite/$OS/lib/libsqlite3.a \
    -DIconv_INCLUDE_DIR=$SDKPATH/usr \
    -DIconv_LIBRARY=$SDKPATH/usr/lib/libiconv.tbd \
    -DGDAL_USE_GEOS=OFF \
    -DGDAL_USE_MRSID=ON \
    -DMRSID_INCLUDE_DIR=$SRC/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80/Raster_DSDK/include \
    -DMRSID_LIBRARY=$SRC/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80/Raster_DSDK/lib \
    -DBUILD_TESTING=OFF \
    -DOGR_BUILD_OPTIONAL_DRIVERS=OFF \
    -DGDAL_BUILD_OPTIONAL_DRIVERS=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DGDAL_HIDE_INTERNAL_SYMBOLS=OFF \
    -DGDAL_USE_INTERNAL_LIBS=ON \
    -DGDAL_USE_EXTERNAL_LIBS=OFF \
    ..

cmake --build .
cmake --build . --target install

cd $SCRIPTS