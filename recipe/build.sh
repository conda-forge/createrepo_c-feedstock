#!/usr/bin/env bash

mkdir build
cd build

# FindPython searches beyond the host prefix and will settle on the build
# image's own python, which has no development headers, whenever that outranks
# the one being built against. Name the interpreter so no search happens.
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DPython_EXECUTABLE="${PYTHON}" \
      -DENABLE_DRPM=ON \
      -DWITH_LIBMODULEMD=ON \
      -DWITH_ZCHUNK=ON \
      ..

make "-j${CPU_COUNT}"

make "-j${CPU_COUNT}" install

make "-j${CPU_COUNT}" tests
make ARGS="-V" test
