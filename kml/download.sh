#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e libkml-$KML_VERSION ]
then
curl -L -O "https://github.com/libkml/libkml/archive/refs/tags/$KML_VERSION.tar.gz"
tar -xzf $KML_VERSION.tar.gz
fi
cd $SCRIPTS