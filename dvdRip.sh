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
DVD_CONTAINER_LABEL=$DVDLABEL-$(date +"%m%d%y_%H%M%S")


DVD_OUTPUT_CONTAINER_DIR="$OUTPUT_DIR/$DVD_CONTAINER_LABEL"
DVD_OUTPUT_DIR="$DVD_OUTPUT_CONTAINER_DIR/$DVDLABEL"

mkdir -p $DVD_OUTPUT_DIR

#check if already ripped here
# will not check this, make rips versioned by date instead of checking.
#---

CONSOLE_LOG_FILE=$DRIPPER_DIR/logs/$DVD_CONTAINER_LABEL-copylog.txt

echo "dvdbackup -M -p -v -i $DEVICE -n $DVDLABEL -o $DVD_OUTPUT_CONTAINER_DIR"
dvdbackup -M -p -v -i $DEVICE -n $DVDLABEL -o $DVD_OUTPUT_CONTAINER_DIR > $CONSOLE_LOG_FILE 2>&1

MOUNTPOINT="$DRIPPER_DIR/python/getDVDMountPoint $DEVICE"
DETAILS_FILE="$DVD_OUTPUT_CONTAINER_DIR/Disc-Details.txt"

echo "dvd-title=$TITLE" >> $DETAILS_FILE
cp $CONSOLE_LOG_FILE $DVD_OUTPUT_CONTAINER_DIR


#SCREENSHOT LONGEST TITLE HERE (FOR QUICK ID)
LONGESTTITLE=`$DRIPPER_DIR/dvdDetails.sh $DVD_OUTPUT_DIR longest | sed 's/feature = //'`
TITLESECONDS=`$DRIPPER_DIR/dvdDetails.sh $DVD_OUTPUT_DIR seconds | sed 's/seconds = //'`

NOOFSCREENSHOTS=5
STARTSECONDS=$( printf "%.0f" `echo "$TITLESECONDS*0.1" | bc` )
INTERVALSECONDS=$( printf "%.0f" `echo "(($TITLESECONDS - $STARTSECONDS)*0.95)/$NOOFSCREENSHOTS" | bc` )

mplayer dvd://$LONGESTTITLE -dvd-device $DVD_OUTPUT_DIR -ss $STARTSECONDS -sstep $INTERVALSECONDS -vo jpeg:outdir=$DVD_OUTPUT_CONTAINER_DIR -nosound -frames $NOOFSCREENSHOTS -zoom -xy 800 > $CONSOLE_LOG_FILE 2>&1

# make iso
echo "making iso" > $CONSOLE_LOG_FILE
mkisofs -dvd-video -udf -o "$DVD_OUTPUT_CONTAINER_DIR/$TITLE.iso" $DVD_OUTPUT_DIR > $CONSOLE_LOG_FILE 2>&1

# delete output folder
rm -rf $DVD_OUTPUT_DIR

#THE FILES ARE READY TO BE COPIED TO THE SERVER
echo $DVD_OUTPUT_CONTAINER
rsync -avz -e 'ssh -i /home/mike/.ssh/id_rsa' $DVD_OUTPUT_CONTAINER_DIR mike@192.168.1.150:/mnt/media-rips/DVD/ > $CONSOLE_LOG_FILE 2>&1

# FINALLY, REMOVE THE FILES!
rm -r $DVD_OUTPUT_CONTAINER_DIR

echo "ejecting disk: $DEVICE"
umount $DEVICE
eject $DEVICE

