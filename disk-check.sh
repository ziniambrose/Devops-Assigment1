
#!/usr/bin/env bash
set -u

LOG_DIR="logs"
mkdir -p "$LOG_DIR"

usage() {
    echo "Usage: $0 THRESHOLD [PATH]" >&2
    echo "THRESHOLD must be an integer from 1 to 100." >&2
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
    exit 2
fi

threshold="$1"
target="${2:-/}"

if [[ ! "$threshold" =~ ^[0-9]+$ ]]; then
    usage
    exit 2
fi

if (( threshold < 1 || threshold > 100 )); then
    usage
    exit 2
fi

if [[ ! -d "$target" ]]; then
    echo "Error: directory does not exist: $target" >&2
    exit 2
fi

usage_percent=$(df -P "$target" | awk 'NR == 2 {gsub(/%/, "", $5); print $5}')

if [[ ! "$usage_percent" =~ ^[0-9]+$ ]]; then
    echo "Error: could not determine disk usage." >&2
    exit 2
fi

{
    echo "Disk usage check: $(date)"
    echo "Path: $target"
    echo "Used: ${usage_percent}%"
    echo "Threshold: ${threshold}%"
} | tee -a "$LOG_DIR/disk-check.log"

if (( usage_percent >= threshold )); then
    echo "WARNING: disk usage has reached the threshold."
    exit 1
else
    echo "OK: disk usage is below the threshold."
    exit 0
fi
