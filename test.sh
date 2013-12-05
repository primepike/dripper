#!/bin/bash

DEVICE="/dev/sr0"
SAFE_DEVICE= echo `echo "$DEVICE" | tr '/' '#'`
echo "$SAFE_DEVICE"
echo done
