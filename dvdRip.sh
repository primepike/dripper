#!/bin/bash
# AUTO DVD RIP
# By Mike, 2013
# 
# Usage: dvdRip.sh <device>
#

DRIPPER_DIR=$HOME/dripper
OUTPUT_DIR=$HOME/dvd-rips/copy
DEVICE=$1

#Create directory (should already be created)
mkdir -p $OUTPUT_DIR

echo "Ripping DVD on $DEVICE" >> $DRIPPER_DIR/logs/dvd.log

TITLE=`$DRIPPER_DIR/python/getDVDTitle $DEVICE $DRIPPER_DIR/logs/DVDNames.log`
DVDLABEL=`$DRIPPER_DIR/python/getDVDLabel $DEVICE`

echo "$TITLE mounted" >> $DRIPPER_DIR/logs/dvd.log

DVDLABEL=`echo ${DVDLABEL// /_}`
DVDLABEL=$DVDLABEL-$(date +"%m%d%y_%H%M%S")

#check if already ripped here

#---

CONSOLE_LOG_FILE=$DRIPPER_DIR/logs/$DVDLABEL-copylog.txt

dvdbackup -M -p -v -i $DEVICE -n $DVDLABEL  -o $OUTPUT_DIR > $CONSOLE_LOG_FILE 2>&1

MOUNTPOINT="$DRIPPER_DIR/python/getDVDMountPoint $DEVICE"
DVD_OUTPUT_DIR="$OUTPUT_DIR/$DVDLABEL"
DETAILS_FILE="$DVD_OUTPUT_DIR/Disc-Details.txt"

mkdir -p $DVD_OUTPUT_DIR
echo "dvd-title=$TITLE" >> $DETAILS_FILE
cp $CONSOLE_LOG_FILE $OUTPUT_DIR/$DVDLABEL/


echo "ejecting disk: $DEVICE"
umount $DEVICE
eject $DEVICE

