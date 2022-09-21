#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -d curl-$CURL_VERSION ]
then
    curl -L -O "https://github.com/curl/curl/releases/download/curl-7_85_0/curl-$CURL_VERSION.tar.gz"
    tar -xzf curl-$CURL_VERSION.tar.gz
fi

cd $SCRIPTS