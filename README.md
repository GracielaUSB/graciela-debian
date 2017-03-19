# graciela-debian
Debian package for graciela

# User instructions
Just download graciela_2.X.Y-Z~OS~ARCH.deb and install it.

# Maintainer Instructions
To update the package,
 
  * Checkout the appropriate branch (OS-ARCH) and follow the
    instructions in the corresponding README file.

  * Delete the old .deb file with
  	`git rm graciela_2.X'.Y'-Z'~OS~ARCH.deb`

  * Bring the new .deb file with
    `git checkout OS-ARCH "*.deb"`

  * Commit.
