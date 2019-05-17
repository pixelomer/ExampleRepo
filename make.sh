#!/usr/bin/env bash
set -e

dpkg-scanpackages -m -t deb debs > Packages
bzip2 -z -c Packages > Packages.bz2
rm -f Release
cp Release-template Release
cat >> Release <<EOF
MD5Sum:
  $(md5 -q Packages) $(printf $(wc -c < Packages)) Packages
  $(md5 -q Packages.bz2) $(printf $(wc -c < Packages.bz2)) Packages.bz2
SHA256:
  $(shasum -a 256 Packages | awk '{ print $1; }') $(printf $(wc -c < Packages)) Packages
  $(shasum -a 256 Packages.bz2 | awk '{ print $1; }') $(printf $(wc -c < Packages.bz2)) Packages.bz2

EOF
