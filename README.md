# graciela-debian
Debian package for graciela

# User instructions
Just download graciela_2.X-Y.deb and install it.

# Mantainer Instructions
To update the package,
 
  * Change the versions appropriately.
  * Check the DEBIAN/control file.
  * Run `env DESTDIR=$PWD/graciela_2.X-Y make -C $graciela install`, 
    where `$graciela` is the main git repository.
  * Run `fakeroot dpkg-deb --build graciela_2.X-Y`
  * Commit.

