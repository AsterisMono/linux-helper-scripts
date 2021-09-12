#!/bin/bash

snapdate=`date "+%Y%m%d_%H%M%S"`
scrot -b -m ~/Pictures/Screenshot/Screenshot-$snapdate.png
notify-send "Screenshot taken!"
