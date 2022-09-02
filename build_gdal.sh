#!/usr/bin/env bash
echo READ https://github.com/OSGeo/gdal/blob/c355968b1dd8d101c61def354603d5c111f35c95/doc/source/build_hints.rst
echo Build Gdal 
cd $SRC

#https://www.extensis.com/support/developers
if [ ! -e MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz ]
then
echo Downloading mrsid
curl -L -O "https://bin.extensis.com/download/developer/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz" 
tar -xzf MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz
fi

if [ ! -e gdal-$PROJ_VERSION ]
then
echo Downloading gdal
curl -L -O "https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz"
tar -xzf gdal-$GDAL_VERSION.tar.gz
fi

if [  $GDAL_VERSION = 3.5.1 ]
then
echo Downloading cmake patch
curl -L "https://raw.githubusercontent.com/BeinerChes/gdalios/main/PATCH_3.5.1_configure.cmake" -o $SRC/PATCH_configure.cmake
patch gdal-$GDAL_VERSION/cmake/helpers/configure.cmake $SRC/PATCH_configure.cmake
fi

echo Downloading cmake patch for tests
curl -L "https://raw.githubusercontent.com/BeinerChes/gdalios/main/PATCH_CMakeLists.txt" -o $SRC/PATCH_CMakeLists.txt
patch gdal-$GDAL_VERSION/CMakeLists.txt $SRC/PATCH_CMakeLists.txt


cd gdal-$GDAL_VERSION
#rm -r build_$OS;
if [  ! -e build_$OS ]
then
mkdir build_$OS; 
fi

cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DBUILD_APPS=OFF \
    -DBUILD_PYTHON_BINDINGS=OFF \
    -DPROJ_ROOT=$PREFIX \
    -DSQLITE3_INCLUDE_DIR=$PREFIX/include \
    -DSQLITE3_LIBRARY=$PREFIX/lib/libsqlite3.a \
    -DIconv_INCLUDE_DIR=$SDKPATH/usr \
    -DIconv_LIBRARY=$SDKPATH/usr/lib/libiconv.tbd \
    -DGDAL_USE_GEOS=ON \
    -DGEOS_INCLUDE_DIR=$PREFIX/include \
    -DGEOS_LIBRARY=$PREFIX/lib \
    -DGDAL_USE_MRSID=ON \
    -DMRSID_INCLUDE_DIR=$SRC/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80/Raster_DSDK/include \
    -DMRSID_LIBRARY=$SRC/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80/Raster_DSDK/lib \
    -DGDAL_ENABLE_DRIVER_JP2MRSID=YES \
    -DOGR_BUILD_OPTIONAL_DRIVERS=ON \
    -GDAL_BUILD_OPTIONAL_DRIVERS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build .
cmake --build . --target install

cd $SCRIPTS

