#!/usr/bin/env bash
set -e
cd $SRC
if [ ! -d $SRC/sqlite-amalgamation ]
then
    git clone https://github.com/BeinerChes/sqlite-amalgamation;
fi

cd $SCRIPTS