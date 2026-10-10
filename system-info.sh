
#!/usr/bin/env bash
set -u

LOG_DIR="logs"
mkdir -p "$LOG_DIR"

{
    echo "===== System Information ====="
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
    echo "Date: $(date)"
} | tee -a "$LOG_DIR/system-info.log"
