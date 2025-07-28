# Epoch Monitor (PowerShell)

A tiny PowerShell script that checks if the Project Epoch Auth-server is reachable. If the status changes, it will show a windows notification in the bottom right corner. 

## What it does

- TCP-connects to the server/port on a fixed interval  
- Prints status (`UP`/`DOWN`) with timestamp to the console  
- Shows a notification:
  - On state changes (UP ⇄ DOWN)
  - Optionally every loop while it’s DOWN  
- Optionally logs each line to a file

## Requirements

- Windows 10/11  
- Windows PowerShell 5.x (built-in)  

## Config

Edit the **Config** block at the top (to your liking):

| Variable                | Type    | Default | Meaning |
|-------------------------|---------|---------|---------|
| `$server`               | string  | `game.project-epoch.net` | Host to check |
| `$port`                 | int     | `3724`  | Port to check, change to 8085 for monitoring world server instead |
| `$delaySeconds`         | int     | `15`    | Interval between checks (seconds) |
| `$NotificationOnChange` | bool    | `$true` | Show notification when status changes |
| `$NotificationWhenDown` | bool    | `$false`| Show notification on **every** DOWN check |
| `$showTestNotification` | bool    | `$true` | Fire a test notification at script start |
| `$LogToFile`            | bool    | `$false`| Enable/disable logging to file |
| `$log`                  | string  | `C:\Temp\Epoch-log.txt` | Log path (used only if `$LogToFile` = `$true`) |

## Run
Remember that running powershell scripts must be allowed on your PC. You can change this setting by using the Set-ExecutionPolicy cmdlet.
```powershell
# From a powershell console:
.\EpochMonitor.ps1
