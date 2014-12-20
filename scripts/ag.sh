#!/bin/bash
set -e
set -x

_BUILD_TARGET_DOWNLOAD=${_BUILD_TARGET_DOWNLOAD-/tmp/build/download}
_BUILD_TARGET_MAKE=${_BUILD_TARGET_MAKE-/tmp/build/make}

mkdir -p $_BUILD_TARGET_DOWNLOAD $_BUILD_TARGET_MAKE
cd $_BUILD_TARGET_DOWNLOAD/

sudo yum -qy groupinstall 'Development Tools'
sudo yum -qy install pcre-devel xz-devel

if [ ! -d  "$_BUILD_TARGET_DOWNLOAD/the_silver_searcher" ]; then
  git clone https://github.com/ggreer/the_silver_searcher.git
fi
cd "$_BUILD_TARGET_DOWNLOAD/the_silver_searcher"
./build.sh
make
sudo make install

if [ ! -d "~/.vim/bundle/vimproc.vim/" ]; then
  cd ~/.vim/bundle/vimproc.vim/
  make
  sudo make install
else
  echo "unable to enable vim silver searcher plugin"
fi
