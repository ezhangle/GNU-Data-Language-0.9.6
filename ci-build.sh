#!/bin/bash

set -e

mkdir build
cd build

mv /usr/bin/sh.exe /usr/bin/sh-moved.exe

wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bsd-xdr/bsd-xdr-1.0.0.tar.gz
tar zxvf bsd-xdr-1.0.0.tar.gz
cd bsd-xdr-1.0.0
make
cd ..

pacman --sync --noconfirm --noprogressbar mingw-w64-i686-readline mingw-w64-i686-libpng mingw-w64-i686-gsl mingw-w64-i686-cmake
cmake -G "MinGW Makefiles" ..

make
