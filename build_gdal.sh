#!/usr/bin/env bash
echo Build Gdal 
cd $SRC

#if [ ! -e gdal-$PROJ_VERSION ]
#then
#echo Downloading gdal
#curl -L -O "https://github.com/OSGeo/gdal/releases/download/v$GDAL_VERSION/gdal-$GDAL_VERSION.tar.gz"
#tar -xzf gdal-$GDAL_VERSION.tar.gz
#fi

#if [  $GDAL_VERSION = 3.5.1 ]
#then
#echo Downloading cmake patch
#curl -L "https://raw.githubusercontent.com/BeinerChes/gdaliospatch/main/PATCH_configure.cmake" -o $SRC/PATCH_configure.cmake
#patch gdal-$GDAL_VERSION/cmake/helpers/configure.cmake $SRC/PATCH_configure.cmake
#fi

#if [  $GDAL_VERSION = 3.5.1 ]
#then
#echo Downloading cmake patch
#curl -L "https://raw.githubusercontent.com/BeinerChes/gdaliospatch/main/PATCH_configure.cmake" -o $SRC/PATCH_configure.cmake
#patch gdal-$GDAL_VERSION/cmake/helpers/configure.cmake $SRC/PATCH_configure.cmake
#fi

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
    -BUILD_TESTING=OFF \
    -DBUILD_TESTING=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build .
cmake --build . --target install

cd $SCRIPTS

