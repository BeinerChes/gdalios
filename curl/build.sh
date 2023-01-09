#!/bin/sh
OS=$1
PREFIX=$INSTALL/curl/$OS

cd $SRC/curl-7.86.0

if [ -d build_$OS ] 
then
rm -r build_$OS
fi
mkdir build_$OS
cd build_$OS

cmake -DCMAKE_TOOLCHAIN_FILE=$CMTOOLCHAIN \
    -DDEPLOYMENT_TARGET=$DEPLOYMENT_TARGET \
    -DPLATFORM=$OS \
    -DENABLE_BITCODE=OFF \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=OFF \
    -DOPENSSL_INCLUDE_DIR=$INSTALL/openssl/$OS/include \
    -DOPENSSL_SSL_LIBRARY=$INSTALL/openssl/$OS/lib/libssl.a \
    -DOPENSSL_CRYPTO_LIBRARY=$INSTALL/openssl/$OS/lib/libcrypto.a \
    -DBUILD_CURL_EXE=OFF \
    -DBUILD_TESTING=OFF \
    ..

cmake --build . --config Release --target install

cd $SCRIPTS