#!/bin/bash
#

DEVICE=$1
COMMAND=$2

TITLE=`lsdvd $DEVICE 2>/dev/null | grep 'Disc Title' | awk '{ print $3}'`
TRACK=`lsdvd $DEVICE 2>/dev/null | grep 'Longest track' | awk '{ print $3}'`
LENGTH=`lsdvd $DEVICE 2>/dev/null | grep "Title: $TRACK" | awk '{ print $4}'`
MINUTES=`echo "$LENGTH" | awk '{split($1, a, ":"); print a[1]*60+a[2]+1}'`
SECONDS=`echo $[60*$MINUTES]`

if [ $COMMAND == 'title'  ]; then 
    echo title = $TITLE
fi

if [ $COMMAND == 'longest'  ]; then 
    echo feature = $TRACK
fi

if [ $COMMAND == 'length'  ]; then 
    echo length = $LENGTH
fi

if [ $COMMAND == 'minutes'  ]; then 
    echo minutes = $MINUTES
fi

if [ $COMMAND == 'seconds'  ]; then 
    echo seconds = $SECONDS
fi

if [ $COMMAND == 'all' ]; then 
    echo title = $TITLE
    echo feature = $TRACK
    echo length = $LENGTH
    echo minutes = $MINUTES
    echo seconds = $SECONDS
fi
