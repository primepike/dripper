#!/bin/bash
#

DEVICE=$1

TITLE=`lsdvd $DEVICE | grep 'Disc Title' | awk '{ print $3}'`
TRACK=`lsdvd $DEVICE | grep 'Longest track' | awk '{ print $3}'`
LENGTH=`lsdvd $DEVICE | grep "Title: $TRACK" | awk '{ print $4}'`
MINUTES=`echo "$LENGTH" | awk '{split($1, a, ":"); print a[1]*60+a[2]+1}'`
SECONDS=`echo $[60*$MINUTES]`

echo title = $TITLE
echo feature = $TRACK
echo length = $LENGTH
echo minutes = $MINUTES
echo seconds = $SECONDS


