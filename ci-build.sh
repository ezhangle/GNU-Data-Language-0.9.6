#!/bin/bash

set -e

mkdir build
cd build

wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bsd-xdr/bsd-xdr-1.0.0.tar.gz
tar zxvf bsd-xdr-1.0.0.tar.gz
cd bsd-xdr-1.0.0
sed -i 's/%hh/%/g' src/test/test_data.c
make
mv mingw/libxdr.dll.a /usr/lib/
mv rpc /usr/include/
cd ..

pacman --sync --noconfirm --noprogressbar mingw-w64-i686-readline mingw-w64-i686-libpng mingw-w64-i686-gsl mingw-w64-i686-cmake

mv /usr/bin/sh.exe /usr/bin/sh-moved.exe
cmake -G "MinGW Makefiles" ..

make
