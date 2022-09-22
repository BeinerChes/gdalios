#!/bin/sh
OS=$1
PREFIX=$INSTALL/proj/$OS

cd $SRC/proj-$PROJ_VERSION

if [ -d build_$OS ] 
then
rm -r build_$OS
fi
mkdir build_$OS
cd build_$OS

#https://proj.org/install.html#cmake-configure-options
cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DDEPLOYMENT_TARGET=$DEPLOYMENT_TARGET \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DSQLITE3_INCLUDE_DIR=$INSTALL/sqlite/$OS/include \
    -DSQLITE3_LIBRARY=$INSTALL/sqlite/$OS/lib/libsqlite3.a \
    -DENABLE_TIFF=ON \
    -DTIFF_INCLUDE_DIR=$INSTALL/tiff/$OS/include \
    -DTIFF_LIBRARY_RELEASE=$INSTALL/tiff/$OS/lib/libtiff.a \
    -DENABLE_CURL=OFF \
    -DBUILD_PROJSYNC=OFF \
    -DBUILD_TESTING=OFF \
    -DBUILD_APPS=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS