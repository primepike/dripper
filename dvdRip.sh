#!/bin/bash
# AUTO DVD RIP
# By Mike, 2013
# 
# Usage: dvdRip.sh <device>
#

DRIPPER_DIR=$HOME/dripper
OUTPUT_DIR=$HOME/dvd-rips/copy
DEVICE=$1

#Create directory
mkdir -p $OUTPUT_DIR

echo "Ripping DVD on $DEVICE" >> $DRIPPER_DIR/logs/dvd.log

TITLE=`$DRIPPER_DIR/python/getDVDTitle $DEVICE $DRIPPER_DIR/logs/DVDNames.log`
DVDLABEL=`$DRIPPER_DIR/python/getDVDLabel $DEVICE`

echo "$TITLE mounted" >> $DRIPPER_DIR/logs/dvd.log

#check if already ripped here

dvdbackup -M -i $DEVICE -o $OUTPUT_DIR

echo "$TITLE" > $OUTPUT_DIR/$DVDLABEL/discName.txt

echo "ejecting disk: $DEVICE"
umount $DEVICE
eject $DEVICE

