#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e libwebp-$WEBP_VERSION ]
then
curl -L -O "https://github.com/webmproject/libwebp/archive/refs/tags/v$WEBP_VERSION.tar.gz"
tar -xzf v$WEBP_VERSION.tar.gz
fi
cd $SCRIPTS