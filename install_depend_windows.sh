install_mingw_pkg() {
  echo "Downloading $package..."
  svn checkout https://github.com/Alexpux/MINGW-packages/trunk/mingw-w64-$package
  
  cd mingw-w64-$package
  . PKGBUILD

  srcdir=`pwd`
  for f in ${source[@]}; do
    if [[ $f == *":"* ]]; then
      curl -O $f
    fi
  done
  
  echo "Decompressing $package..."
  tar zxf `basename $source` # 1st file is to be decompressed
  
  echo "Preparing for $package..."
  libdir=/usr/${MINGW_CHOST}/lib
  if [[ $package == "readline" ]]; then # readline specific patch
    sed -i 's|linux\*-\*\|gnu\*-\*\|k\*bsd\*-gnu-\*\|freebsd\*-gentoo|mingw*|g' ${_realname}-${_basever}/support/shobj-conf
  fi
  prepare
  
  echo "Building $package..."
  build
  
  echo "Installing $package..."
  pkgdir=/usr/${MINGW_CHOST}
  package
  
  echo "Installed $package."
  cd ..
}

MINGW_CHOST=i586-mingw32msvc

mkdir depend_windows && cd depend_windows
package=readline && install_mingw_pkg
