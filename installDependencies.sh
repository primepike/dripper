#!/bin/bash
#
# for ubuntu

if [ "$(whoami)" != "root" ]; then
	echo "need sudo to run"
	exit 1
fi

DVDFINGERPRINT_DIR=python/dvdfingerprint

add-apt-repository -y ppa:aguignard/ppa
echo "deb http://download.videolan.org/pub/debian/stable/ /" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://download.videolan.org/pub/debian/stable/ /" | sudo tee -a /etc/apt/sources.list
wget -O - http://download.videolan.org/pub/debian/videolan-apt.asc|sudo apt-key add -
#apt-get install --yes -q --allow-unauthenticated medibuntu-keyring

apt-get update
apt-get install --yes vim git abcde cdparanoia lame udisks-glue flac libdvdcss2 dvdbackup lsdvd mplayer mkisofs

git clone https://github.com/kolanos/dvdfingerprint.git $DVDFINGERPRINT_DIR
cd $DVDFINGERPRINT_DIR
python setup.py install

cd ../../
