
#! /bin/bash

set -e

WORKSPACE=/tmp/workspace
mkdir -p $WORKSPACE
mkdir -p /work/artifact

# zopfli
cd $WORKSPACE
git clone  https://github.com/google/zopfli.git
cd zopfli
mkdir build
cd build
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr/local/zopflimm -DCMAKE_BUILD_TYPE=MinSizeRel -DBUILD_SHARED_LIBS=OFF -DCMAKE_EXE_LINKER_FLAGS="-static --static -no-pie -s" ..
ninja
ninja install

# mozjpeg
git clone https://github.com/mozilla/mozjpeg.git
cd mozjpeg
mkdir build
cd build
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=/usr/local/mozjpegmm -DWITH_JPEG8=1  -DCMAKE_BUILD_TYPE=MinSizeRel -DBUILD_SHARED_LIBS=OFF -DCMAKE_EXE_LINKER_FLAGS="-static --static -no-pie -s" ..
ninja
ninja install

# guetzli-cuda-opencl
git clone https://github.com/ianhuang-777/guetzli-cuda-opencl.git
cd guetzli-cuda-opencl
CFLAGS=-static LDFLAGS="-static --static -no-pie -s -lpng16 -lz" make
cd bin/Release
tar vcJf guetzlimm.tar.xz guetzli libguetzli_static.a
mv ./guetzlimm.tar.xz /work/artifact/

cd /usr/local
tar vcJf ./zopflimm.tar.xz zopflimm
tar vcJf ./mozjpegmm.tar.xz mozjpegmm

mv ./zopflimm.tar.xz /work/artifact/
mv ./mozjpegmm.tar.xz /work/artifact/
