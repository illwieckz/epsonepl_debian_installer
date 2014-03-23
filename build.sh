#! /bin/sh

# AUTHOR: Thomas DEBESSE <dev@illwieckz.net>
# VERSION: 20140222
# License: Expat

version='0.4.1'
project='epsonepl'
driver='epsoneplijs'
workspace='workspace'
dir="${driver}-${version}"
archive="${dir}.tgz"

mkdir -p "${workspace}"
cd "${workspace}"

wget -nd -c "http://sourceforge.net/projects/${project}/files/${project}/${version}/${archive}/download" -O "${archive}"
tar -xzf "${archive}"

cd "${dir}"
./configure --prefix='/usr'
make

cat > install.sh <<\EOF
make install
cd foomatic_scripts/
./install_debian
EOF

chmod +x install.sh

fakeroot checkinstall --default --pkgname="${driver}" --pkgversion="${version}" --pkglicense 'unknown' --fstrans --install='no' make install
cp -a "${driver}_"${version}"-1_"*".deb" ..

#EOF
