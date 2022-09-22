#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e geos-$GEOS_VERSION ]
then
curl -L -O "https://github.com/libgeos/geos/releases/download/$GEOS_VERSION/geos-$GEOS_VERSION.tar.bz2"
tar -xzf geos-$GEOS_VERSION.tar.bz2
fi
cd $SCRIPTS