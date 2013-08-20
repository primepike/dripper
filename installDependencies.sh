#!/bin/bash
#
# for ubuntu

if [ "$(whoami)" != "root" ]; then
	echo "need sudo to run"
	exit 1
fi

DVDFINGERPRINT_DIR=python/dvdfingerprint

apt-get install --yes -q --allow-unauthenticated medibuntu-keyring
apt-get update
apt-get install --yes vim git abcde cdparanoia lame udisks-glue flac libdvdcss2 dvdbackup

git clone https://github.com/kolanos/dvdfingerprint.git $DVDFINGERPRINT_DIR
cd $DVDFINGERPRINT_DIR
python setup.py install

cd ../../
