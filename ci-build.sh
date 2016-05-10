#!/bin/bash

set -e

if test "$platform" = "bash"; then
    echo "Building on Ubuntu Linux x86_64"
    sudo apt-get install build-essential automake
elif test "$platform" = "mingw32"; then
    echo "Building on MinGW-w64 i686"
    pacman --sync --noconfirm --noprogressbar mingw-w64-i686-readline
else
    echo "unknown environment!"
    exit 1
fi

mkdir build
cd build
cmake ..
make
