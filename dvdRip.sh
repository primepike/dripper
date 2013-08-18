#!/bin/bash
# AUTO DVD RIP
# By Mike, 2013
# 
# Usage: dvdRip.sh <device>
#

DRIPPER_DIR=/home/mike/dripper
OUTPUT_DIR=$HOME/dvd-rips/copy
DEVICE=$1

echo "DVD $DEVICE inserted" >> dvd.log

TITLE=`$DRIPPER_DIR/python/getDVDTitle $DEVICE`
DVDLABEL=`$DRIPPER_DIR/python/getDVDLabel $DEVICE`

echo "$TITLE mounted" >> dvd.log

dvdbackup -M -i $DEVICE -o $OUTPUT_DIR

echo "$TITLE" > $OUTPUT_DIR/$DVDLABEL/discName.txt
