# ---------- Config ----------
$server                  = "game.project-epoch.net"
$port                    = 3724
$log                     = "C:\Temp\Epoch-log.txt"
$delaySeconds            = 15
$NotificationOnChange    = $true   # notify when state changes
$NotificationWhenDown    = $false  # notify every check while DOWN
$showTestNotification    = $true   # pop a test at start
$LogToFile               = $false
$log                     = "C:\Temp\Epoch-log.txt"
# ----------------------------

function Show-Notification {
    param([string]$Title,[string]$Message)
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $ni = New-Object System.Windows.Forms.NotifyIcon
    $ni.Icon = [System.Drawing.SystemIcons]::Information
    $ni.Visible = $true
    $ni.BalloonTipTitle = $Title
    $ni.BalloonTipText  = $Message
    $ni.ShowBalloonTip(5000)
    Start-Sleep 6
    $ni.Dispose()
}

if ($showTestNotification) {
    Show-Notification -Title "Test Notification" -Message "Notification test"
}

# log if enabled in config only
if ($LogToFile) {
    $dir = Split-Path $log
    if (!(Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    if (!(Test-Path $log)) { New-Item -ItemType File -Path $log -Force | Out-Null }
}

$lastStatus = $null

while ($true) {
    $ok        = (Test-NetConnection -ComputerName $server -Port $port -WarningAction SilentlyContinue).TcpTestSucceeded
    $status    = if ($ok) { "UP" } else { "DOWN" }
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $line      = "{0} {1}" -f $timestamp, $status

    # Console output always
    Write-Host $line

    # File logging only if enabled
    if ($LogToFile) {
        Add-Content -Path $log -Value $line
    }

    $stateChanged = ($lastStatus -ne $null -and $status -ne $lastStatus)

    if ( ($NotificationOnChange -and $stateChanged) -or ($NotificationWhenDown -and -not $ok) ) {
        Show-Notification -Title "Epoch is $status" -Message "Port $port on $server @ $(Get-Date -Format 'HH:mm:ss')"
    }

    $lastStatus = $status
    Start-Sleep -Seconds $delaySeconds
}