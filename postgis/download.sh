#!/bin/bash

set -e

cd $SRC

# Check if the libpq source code directory already exists
if [ ! -d "postgresql-${LIBPQ_VERSION}" ]; then
  # If the directory doesn't exist, extract the libpq source code archive
  if [ ! -f "postgresql-${LIBPQ_VERSION}.tar.gz" ]; then
    # If the archive doesn't exist, download it using curl
    curl -LO "https://ftp.postgresql.org/pub/source/v${LIBPQ_VERSION}/postgresql-${LIBPQ_VERSION}.tar.gz"
  fi
  tar zxvf "postgresql-${LIBPQ_VERSION}.tar.gz"
fi

cd $SCRIPTS