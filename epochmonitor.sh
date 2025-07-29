#!/bin/bash

# === Configuration ===
SERVER="game.project-epoch.net"
PORT=3724
DELAY=15
NOTIFY_ON_CHANGE=true
NOTIFY_WHEN_DOWN=false
LOG_TO_FILE=false
LOGFILE="$HOME/epochmonitor.log"

# === Internal state ===
prev_status="UNKNOWN"

notify() {
  local title="EpochMonitor"
  local message="$1"
  osascript -e "display notification \"${message//\"/\\\"}\" with title \"${title}\""
}

while true; do
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  nc -z -w5 "$SERVER" "$PORT"
  exit_code=$?

  if [ $exit_code -eq 0 ]; then
    status="UP"
  else
    status="DOWN"
  fi

  echo "[$timestamp] $SERVER:$PORT is $status"

  if [ "$LOG_TO_FILE" = true ]; then
    echo "[$timestamp] $SERVER:$PORT is $status" >> "$LOGFILE"
  fi

  if [ "$status" != "$prev_status" ]; then
    if [ "$NOTIFY_ON_CHANGE" = true ]; then
      notify "$SERVER:$PORT changed to $status"
    fi
  elif [ "$status" = "DOWN" ] && [ "$NOTIFY_WHEN_DOWN" = true ]; then
    notify "$SERVER:$PORT is still DOWN"
  fi

  prev_status=$status
  sleep "$DELAY"
done
