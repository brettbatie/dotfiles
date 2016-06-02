#!/bin/sh

pid=$(pgrep --uid $USER -x dunst)
if [ -n "$pid" ]; then
  kill $pid
fi

/usr/bin/dunst "$@" &

if [ -n "$pid" ]; then
  notify-send "Killed old dunst: $pid"
fi
