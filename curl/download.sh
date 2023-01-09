#!/usr/bin/env bash
#https://github.com/curl/curl/releases
#https://github.com/curl/curl/releases/download/curl-7_86_0/curl-7.86.0.tar.gz
set -e
cd $SRC
if [ ! -d curl-7.86.0 ]
then
    curl -L -O "https://github.com/curl/curl/releases/download/curl-7_86_0/curl-7.86.0.tar.gz"
    tar -xzf curl-7.86.0.tar.gz
fi

cd $SCRIPTS