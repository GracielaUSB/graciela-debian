#!/usr/bin/env bash

# Automatic deb file creation.

# 0. Set unofficial strict mode (http://redsymbol.net/articles/unofficial-bash-strict-mode/)
set -euo pipefail
IFS=$'\n\t'

# 1. Set and check variables
source vars.sh
GRACIELA_GIT=${GRACIELA_GIT/#\~/$HOME}
if [ -z ${GRACIELA_VERSION:-""} ]; then
    echo 'Variable $GRACIELA_VERSION must be set'
    exit 1
fi
if [ -z ${GRACIELA_GIT:-""} ]; then
    echo 'Variable $GRACIELA_GIT must be set'
    exit 1
fi

# 2. Remove the old deb.
rm -f *.deb

# 3. Update DEBIAN/control file
echo "\
Package: graciela
Version: $GRACIELA_VERSION
Section: misc
Priority: optional
Architecture: $GRACIELA_ARCH
Depends: clang-3.5 (>= 1:3.5), libc6 (>= 2.19)
Maintainer: Moisés Ackerman <unacson@gmail.com>
Description: Installs the graciela compiler and runtime libraries\
" > graciela/DEBIAN/control

# 4. Pull graciela
( cd ${GRACIELA_GIT/#\~/$HOME}; git pull )

# 5. Make graciela
make -C $GRACIELA_GIT

# 6. Make install graciela
env DESTDIR=$PWD/graciela make -C $GRACIELA_GIT install

# 7. Rename graciela folder to include version and distribution
graciela_vda="graciela_${GRACIELA_VERSION}~${GRACIELA_DISTR}~${GRACIELA_ARCH}"
mv graciela $graciela_vda

# 8. Build the package
fakeroot dpkg-deb --build $graciela_vda

# 9. Rename graciela folder back
mv $graciela_vda graciela
