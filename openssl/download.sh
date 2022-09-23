#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -e openssl-cmake ]
then
    git clone https://github.com/BeinerChes/openssl-cmake
fi
cd $SCRIPTS