# Epoch Monitor (Bash)

A lightweight Bash script for macOS that checks if the Project Epoch Auth-server is reachable. If the status changes, it shows a macOS notification and logs the result to the console.

Forked from 'https://github.com/dahlish/epochmonitor'

## What it does

- TCP-connects to the server/port on a fixed interval  
- Prints status (`UP`/`DOWN`) with timestamp to the terminal  
- Shows a macOS notification:
  - On state changes (UP ⇄ DOWN)
  - Optionally every loop while it’s DOWN  
- Optionally logs each line to a file

## Requirements

- macOS (tested on Ventura and later)  
- `nc` (netcat – pre-installed on macOS)
- `osascript` (for notifications – built into macOS)
- `bash` (or compatible shell)

## Config

Edit the **configuration block** at the top of the script to customize behavior:

| Variable                | Type   | Default                      | Description |
|-------------------------|--------|------------------------------|-------------|
| `SERVER`                | string | `game.project-epoch.net`     | Host to check |
| `PORT`                  | int    | `3724`                       | Port to check (use 8085 for world server) |
| `DELAY`                 | int    | `45`                         | Interval between checks in seconds |
| `NOTIFY_ON_CHANGE`      | bool   | `true`                       | Show notification when server status changes |
| `NOTIFY_WHEN_DOWN`      | bool   | `false`                      | Show notification on every DOWN status |
| `LOG_TO_FILE`           | bool   | `false`                      | Log output to a file |
| `LOGFILE`               | string | `$HOME/epochmonitor.log`     | Path for log file if logging is enabled |

## Run

1. **Make script executable**:
   ```bash
   chmod +x epochmonitor.sh
