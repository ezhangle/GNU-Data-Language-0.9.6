install_pkg() {
  echo "Downloading $pkgname..."
  svn checkout https://github.com/Alexpux/MINGW-packages/trunk/mingw-w64-$pkgname
  . mingw-w64-$pkgname/PKGBUILD
  curl -O $source
  source_fn=`basename $source`
  source_dn=`basename $source_fn .tar.gz`
  echo "Decompressing $pkgname..."
  tar zxf $source_fn
  cd $source_dn
  if [[ -f ../${source_dn}-mingw.patch ]]; then
    echo "Applying patch for $pkgname..."
    patch -p0 ../${source_dn}-mingw.patch
  fi
  echo "Configuring $pkgname..."
  ./configure --prefix=/usr/${_toolchain}/ --host ${_toolchain}
  echo "Building $pkgname..."
  make && make install
  cd ..
  echo "Installed $pkgname."
}

_toolchain=i586-mingw32msvc

mkdir depend_windows && cd depend_windows

pkgname=readline
install_pkg
