#!/bin/bash

# Send QQ Notification from vbox machine to Linux host.
# Usage:
# 1. Put msg.wav in shared folder (Z:, $file)
# 2. Set QQ message ringtone to Z:\msg.wav
# 3. Daemonize this script
# Idea originally from https://www.jianshu.com/p/29dc41b6ef44

file=$HOME/QQFileRecv/msg.wav
inotifywait -q -e access $file -m \
	| $HOME/.scripts/burst.sh 2 'notify-send -t 5000 "QQ" "New QQ Message"'
