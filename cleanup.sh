#!/bin/bash
# cleanup command
# mike 



DEVICE=$1
DRIPPER_DIR="$HOME/dripper"
OUTPUT_LOG="$DRIPPER_DIR/logs/cleanup.log"

echo "Attempting to unmount $DEVICE" >> $OUTPUT_LOG
umount -l $DEVICE
echo "exit is $?" >> $OUTPUT_LOG
