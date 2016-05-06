install() {
  svn checkout https://github.com/Alexpux/MINGW-packages/trunk/mingw-w64-$pkgname
  . mingw-w64-$pkgname/PKGBUILD
  curl -O $source
  source_fn=`basename $source`
  source_dn=`basename $source_fn tar.gz`
  tar zxvf $source_fn
  cd $source_dn
  patch -p0 ../${source_dn}-mingw.patch
  ./configure --prefix=/usr/${_toolchain}/
  make && make install
  cd ..
}

_toolchain=i586-mingw32msvc

mkdir depend_windows && cd depend_windows

pkgname=readline
install()
