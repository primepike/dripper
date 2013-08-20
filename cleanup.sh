#!/bin/bash
# cleanup command
# mike 


DRIPPER_DIR="$HOME/dripper"
DEVICE=$1
OUTPUT_LOG="$DRIPPER_DIR/logs/cleanup.log"

echo "Attempting to unmount $DEVICE" >> $OUTPUT_LOG
umount -l $DEVICE
echo "exit is $?" >> $OUTPUT_LOG
