#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e proj-$PROJ_VERSION ]
then
curl -L -O "https://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz"
tar -xzf proj-$PROJ_VERSION.tar.gz
fi
cd $SCRIPTS