#!/bin/bash

set -e

mkdir build
cd build

# wxWidgets
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.0/wxWidgets-3.1.0.zip
unzip wxWidgets-3.1.0.zip
cd wxWidgets-3.1.0
ls

exit 1

# bsd-xdr
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bsd-xdr/bsd-xdr-1.0.0.tar.gz
tar zxvf bsd-xdr-1.0.0.tar.gz
cd bsd-xdr-1.0.0
sed -i 's/%hh/%/g' src/test/test_data.c
make
mv mingw/libxdr.dll.a /mingw32/lib/
mv rpc /mingw32/include/
cd ..

# cmake
pacman --sync --noconfirm --noprogressbar mingw-w64-i686-cmake

# cmake doesn't like sh
mv /usr/bin/sh.exe /usr/bin/sh-moved.exe

# Dependancies for GDL
pacman --sync --noconfirm --noprogressbar mingw-w64-i686-readline mingw-w64-i686-libpng mingw-w64-i686-gsl mingw-w64-i686-pcre
cmake -G "MinGW Makefiles" ..

make
