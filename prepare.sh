#!/usr/bin/env bash
set -e

if [ ! -d $DEV ] 
then
    mkdir $DEV
fi

open $DEV

if [ ! -d $SRC ] 
then
    mkdir $SRC
fi

if [ ! -e $INSTALL ] 
then
    echo mkdir $INSTALL
    mkdir $INSTALL
fi

if [ ! -f "$CMTOOLCHAIN" ]; then
    curl -L -o $CMTOOLCHAIN https://raw.githubusercontent.com/BeinerChes/ios-cmake/master/ios.toolchain.cmake    
fi
