#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e openjpeg-$OPENJPEG_VERSION ]
then
curl -L -O "https://github.com/uclouvain/openjpeg/archive/refs/tags/v$OPENJPEG_VERSION.tar.gz"
tar -xzf v$OPENJPEG_VERSION.tar.gz
fi
cd $SCRIPTS