#!/bin/bash
# AUTO CD RIP
# By Mike, 2013
# 
# Usage: cdRip.sh <device>
#


#OPTS
DRIPPER_DIR="$HOME/dripper"
OUTPUT_LOG="$DRIPPER_DIR/logs/cd.log"
ABCDE_CONF="$DRIPPER_DIR/abcde.conf"

#END OPTS

DEVICE=$1

echo "AUDIO CD $DEVICE inserted" >> $OUTPUT_LOG

#run abcde
#abcde -VVV -c abcde.conf -a read,cddb,tag,move -o flac -p -N
ABCDE_CMD="abcde "
ABCDE_CMD+="-c $ABCDE_CONF "		#PATH TO CONF FILE
ABCDE_CMD+="-N "			#BE QUIET
ABCDE_CMD+="-d $DEVICE "		#USE DEVICE

echo "command is: $ABCDE_CMD" >> $OUTPUT_LOG

CONSOLE_LOG_FILE=$DRIPPER_DIR/logs/cd-$DEVICE-copylog.txt

$ABCDE_CMD > $CONSOLE_LOG_FILE 2>&1

#eject $DEVICE #HANDLED BY ABCDE
echo "finished copying CD: $DEVICE" >> $OUTPUT_LOG
