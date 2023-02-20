#!/bin/bash

set -e

# Set the version of libpq to download and build
#LIBPQ_VERSION="13.1"

# Set the path where the library will be installed
#INSTALL_PATH="$(pwd)/libpq"
OS=$1
INSTALL_PATH=$INSTALL/libpq/$OS
cd $SRC
# Set the architecture of the iOS device you want to build for
ARCH="arm64"

#openssl location 
#/Users/chesbeiner/Documents/gdal_ios/install/openssl/OS64/include
OPEN_SSL_INCLUDE=$INSTALL/openssl/$OS/include/openssl
OPEN_SSL_LIB=INSTALL_PATH=$INSTALL/openssl/$OS/include/lib/libcrypto.a

# Set the path to the Xcode developer directory
XCODE_DEV_DIR="/Applications/Xcode.app/Contents/Developer"

# Get the path to the latest installed iOS SDK on your system
SDK_PATH="$(xcodebuild -showsdks | grep iphoneos | awk '{print $NF}' | sed 's/-sdk//' | tail -1)"

# Download and extract the libpq source code
#curl -L "https://ftp.postgresql.org/pub/source/v${LIBPQ_VERSION}/postgresql-${LIBPQ_VERSION}.tar.gz" | tar zx
cd "postgresql-${LIBPQ_VERSION}"

# Build and install the library for iOS

./configure --host=arm-apple-darwin \
--without-readline \
--prefix="${INSTALL_PATH}" \
CC="${XCODE_DEV_DIR}/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang" \
CFLAGS="-arch ${ARCH} -isysroot ${XCODE_DEV_DIR}/Platforms/iPhoneOS.platform/Developer/SDKs/${SDK_PATH}.sdk" \
LDFLAGS="-arch ${ARCH} -isysroot ${XCODE_DEV_DIR}/Platforms/iPhoneOS.platform/Developer/SDKs/${SDK_PATH}.sdk"

#sudo make -j8
make install

#rm -rf "postgresql-${LIBPQ_VERSION}"

cd $SCRIPTS