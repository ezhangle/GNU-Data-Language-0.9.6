install_pkg() {
  echo "Downloading $pkg_name..."
  svn checkout https://github.com/Alexpux/MINGW-packages/trunk/mingw-w64-$pkg_name
  . mingw-w64-$pkg_name/PKGBUILD
  curl -O $source
  source_fn=`basename $source`
  source_dn=`basename $source_fn .tar.gz`
  echo "Decompressing $pkg_name..."
  tar zxf $source_fn
  cd $source_dn
  echo "../${source_dn}-mingw.patch"
  ls ../${source_dn}-mingw.patch
  if [[ -f ../${source_dn}-mingw.patch ]]; then
    echo "Applying patch for $pkg_name..."
    patch -p0 < ../${source_dn}-mingw.patch
  fi
  echo "Configuring $pkg_name..."
  ./configure --prefix=/usr/${_toolchain}/ --host ${_toolchain}
  echo "Building $pkg_name..."
  make && make install
  cd ..
  echo "Installed $pkg_name."
}

_toolchain=i586-mingw32msvc

mkdir depend_windows && cd depend_windows

pkg_name=readline
install_pkg
