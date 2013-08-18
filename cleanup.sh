#!/bin/bash
# cleanup command
# mike 



DEVICE=$1
OUTPUT_LOG="/home/mike/ripper/cleanup.log"

echo "Attempting to unmount $DEVICE" >> $OUTPUT_LOG
umount -l $DEVICE
echo "exit is $?" >> $OUTPUT_LOG
