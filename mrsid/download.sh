#!/usr/bin/env bash

MRSID_ROOT=$INSTALL/mrsid
if [ -d $MRSID_ROOT ] 
then
rm -r $MRSID_ROOT
fi
mkdir $MRSID_ROOT

cd $SRC
#https://www.extensis.com/support/developers
if [ ! -e MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz ]
then
curl -L -O "https://bin.extensis.com/download/developer/MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz" 
fi

tar -xzf MrSID_DSDK-9.5.4.4709-ios80.universal.clang80.tar.gz

if [ ! -d $MRSID_ROOT ]
then
  cp -rv MrSID_DSDK-9.5.4.4709-ios80.universal.clang80/Raster_DSDK/* "$MRSID_ROOT"
fi



#mkdir -p $MRSID_ROOT/Raster_DSDK/lib/OS64/
#mkdir -p $MRSID_ROOT/Raster_DSDK/lib/SIMULATORARM64/
#mkdir -p $MRSID_ROOT/Raster_DSDK/lib/SIMULATOR64/

#lipo $MRSID_ROOT/Raster_DSDK/lib/libltidsdk.a -thin arm64 \
#    -output $MRSID_ROOT/Raster_DSDK/lib/OS64/libltidsdk.a
#lipo $MRSID_ROOT/Raster_DSDK/lib/libltidsdk.a -thin arm64 \
#    -output $MRSID_ROOT/Raster_DSDK/lib/SIMULATORARM64/libltidsdk.a
#lipo $MRSID_ROOT/Raster_DSDK/lib/libltidsdk.a -thin x86_64 \
#   -output $MRSID_ROOT/Raster_DSDK/lib/SIMULATOR64/libltidsdk.a

cd $SCRIPTS