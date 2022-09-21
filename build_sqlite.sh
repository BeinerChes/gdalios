#!/bin/sh
OS=$1
PREFIX=$INSTALL/sqlite/$OS

cd $SRC
echo  $SRC/sqlite-amalgamation
if [ ! -d $SRC/sqlite-amalgamation ]
then
    git clone https://github.com/BeinerChes/sqlite-amalgamation;
fi

cd sqlite-amalgamation
if [ -d build_$OS ] 
then
rm -r build_$OS
fi
mkdir build_$OS
cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DPLATFORM=$OS \
    -DNAMED_LANGUAGE_SUPPORT=ON \
    -DENABLE_BITCODE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_SHARED_LIBS=OFF \
    -DENABLE_VISIBILITY=ON \
    -DSQLITE_ENABLE_RTREE=ON \
    -DSQLITE_ENABLE_COLUMN_METADATA=ON \
    -DSQLITE_OMIT_DECLTYPE=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    ..
cmake --build .
cmake --build . --target install
cd $SCRIPTS