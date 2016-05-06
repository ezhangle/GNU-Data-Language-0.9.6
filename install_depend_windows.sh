install_mingw_pkg() {
  echo "Downloading $package..."
  svn checkout https://github.com/Alexpux/MINGW-packages/trunk/mingw-w64-$package

  . mingw-w64-$package/PKGBUILD

  mkdir src && srcdir=src
  
  cd src
  for f in ${source[@]}; do
    curl -O $f
  done
  
  echo "Decompressing $package..."
  tar zxf `basename $source`
  
  cd ..

  echo "Preparing for $package..."
  libdir=/usr/${MINGW_CHOST}/lib
  pwd
  prepare
  
  echo "Building $package..."
  build
  
  echo "Installing $package..."
  pkgdir=/usr/${MINGW_CHOST}
  package
  
  cd ..
  echo "Installed $package."
}

MINGW_CHOST=i586-mingw32msvc

mkdir depend_windows && cd depend_windows
package=readline && install_mingw_pkg
