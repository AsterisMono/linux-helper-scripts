#!/bin/sh
# shell script to prepend i3status with more stuff

function get_media_metadata(){
  artist=$(playerctl metadata | grep "artist" | awk '{print $3}')
  title=$(playerctl metadata | grep "title" | awk '{print $3}')
  echo "$title - $artist"
}

i3status | while :
do
        read line
        media_status=$(get_media_metadata)
        echo "$media_status | $line" || exit 1
done
