#!/bin/sh
OS=$1
PREFIX=$INSTALL/sqlite/$OS

cd $SRC/sqlite-amalgamation

if [ -d build_$OS ] 
then
rm -r build_$OS
fi
mkdir build_$OS
cd build_$OS

cmake -G Xcode \
    -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DDEPLOYMENT_TARGET=$DEPLOYMENT_TARGET \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DSQLITE_ENABLE_RTREE=ON \
    -DSQLITE_ENABLE_COLUMN_METADATA=ON \
    -DSQLITE_OMIT_DECLTYPE=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS