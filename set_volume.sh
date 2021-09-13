#!/bin/bash
# Small script for tuning volume from a shell interface.
pactl set-sink-volume @DEFAULT_SINK@ "$1"'%'
