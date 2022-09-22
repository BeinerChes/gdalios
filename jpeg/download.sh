#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e libjpeg-turbo-$LIBJPEG_TURBO_VERSION ]
then
curl -L -O "https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/$LIBJPEG_TURBO_VERSION.tar.gz"
tar -xzf $LIBJPEG_TURBO_VERSION.tar.gz
fi
cd $SCRIPTS