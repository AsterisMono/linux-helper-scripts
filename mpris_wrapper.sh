#!/usr/bin/env bash

# This i3status wrapper allows to add custom information in any position of the statusline
# It was developed for i3bar (JSON format)

# The idea is to define "holder" modules in i3status config and then replace them

# In order to make this example work you need to add
# order += "tztime holder__hey_man"
# and 
# tztime holder__hey_man {
#        format = "holder__hey_man"
# }
# in i3staus config 

# Don't forget that i3status config should contain:
# general {
#   output_format = i3bar
# }
#
# and i3 config should contain:
# bar {
#   status_command exec /path/to/this/script.sh
# }

# Make sure jq is installed
# That's it

# You can easily add multiple custom modules using additional "holders"

function get_media_metadata {
  artist=$(playerctl metadata | grep "artist" | awk '{for (i=3; i<=NF-1; i++) printf $i FS; printf $NF}')
  title=$(playerctl metadata | grep "title" | awk '{for (i=3; i<=NF-1; i++) printf $i FS; printf $NF}')
  status=$(playerctl status)

  if [ "$status" = "Playing" ]; then
    icon=""
  elif [ "$status" = "Paused" ]; then
    icon=""
  else
    icon=""
  fi
  
  if [ "$title" = "" ]
  then
    echo "$icon Start playing"
  else
    echo "$icon $title - $artist"
  fi
}

function update_holder {

  local instance="$1"
  local replacement="$2"
  echo "$json_array" | jq --argjson arg_j "$replacement" "(.[] | (select(.instance==\"$instance\"))) |= \$arg_j" 
}

function remove_holder {

  local instance="$1"
  echo "$json_array" | jq "del(.[] | (select(.instance==\"$instance\")))"
}

function media_status {

  media_metadata=$(get_media_metadata)
  local json='{ "full_text": "'"$media_metadata"'", "color": "#7AD7F0" }'
  json_array=$(update_holder holder_mpris_status "$json")
}

i3status | (read line; echo "$line"; read line ; echo "$line" ; read line ; echo "$line" ; while true
do
  read line
  json_array="$(echo $line | sed -e 's/^,//')"
  media_status
  echo ",$json_array" 
done)

