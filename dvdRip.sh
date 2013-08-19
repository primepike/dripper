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

#---

CONSOLE_LOG_FILE=$DRIPPER_DIR/logs/$DVDLABEL-copylog.txt

dvdbackup -M -p -v -I -i $DEVICE -o $OUTPUT_DIR > $CONSOLE_LOG_FILE 2>&1

MOUNTPOINT="$DRIPPER_DIR/python/getDVDMountPoint $DEVICE"
DETAILS_FILE="$OUTPUT_DIR/$DVDLABEL/Disc-Details.txt"
echo "dvd-title=$TITLE" >> $DETAILS_FILE
cp $CONSOLE_LOG_FILE $OUTPUT_DIR/$DVDLABEL/

echo "ejecting disk: $DEVICE"
umount $DEVICE
eject $DEVICE

