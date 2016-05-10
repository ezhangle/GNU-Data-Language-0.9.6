#!/bin/bash

set -e

mkdir build
cd build

if test "$platform" = "bash"; then
    echo "Building on Ubuntu Linux x86_64"
    sudo apt-get install build-essential automake
    cmake ..
elif test "$platform" = "mingw32"; then
    echo "Building on MinGW-w64 i686"
    mv /usr/bin/sh.exe /usr/bin/sh-moved.exe
    pacman --sync --noconfirm --noprogressbar mingw-w64-i686-readline mingw-w64-i686-libpng mingw-w64-i686-gsl mingw-w64-i686-cmake
    cmake -G "MinGW Makefiles" ..
else
    echo "unknown environment!"
    exit 1
fi

make
