#!/bin/bash
# AUTO CD RIP
# By Mike, 2013
# 
# Usage: cdRip.sh <device>
#


#OPTS
DRIPPER_DIR="$HOME/dripper"
ABCDE_CONF="$DRIPPER_DIR/abcde.conf"

#END OPTS

DEVICE=$1

echo "AUDIO CD $DEVICE inserted" >> $DRIPPER_DIR/logs/cd.log

#run abcde
#abcde -VVV -c abcde.conf -a read,cddb,tag,move -o flac -p -N
ABCDE_CMD="abcde "
ABCDE_CMD+="-c $ABCDE_CONF "		#PATH TO CONF FILE
ABCDE_CMD+="-N "			#BE QUIET
ABCDE_CMD+="-d $DEVICE "		#USE DEVICE

echo "command is: $ABCDE_CMD" >> $DRIPPER_DIR/logs/cd.log

$ABCDE_CMD
