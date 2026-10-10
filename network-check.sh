
#!/usr/bin/env bash
set -u

LOG_DIR="logs"
mkdir -p "$LOG_DIR"

usage() {
    echo "Usage: $0 HOST [PORT]" >&2
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
    usage
    exit 2
fi

host="$1"
port="${2:-80}"

if [[ -z "$host" ]]; then
    usage
    exit 2
fi

if [[ ! "$port" =~ ^[0-9]+$ ]]; then
    echo "Error: port must be numeric." >&2
    usage
    exit 2
fi

if (( port < 1 || port > 65535 )); then
    echo "Error: port must be between 1 and 65535." >&2
    usage
    exit 2
fi

{
    echo "Network check: $(date)"
    echo "Host: $host"
    echo "Port: $port"
} >> "$LOG_DIR/network-check.log"

if ! command -v timeout >/dev/null 2>&1; then
    echo "Error: timeout command is required." >&2
    exit 2
fi

if timeout 3 bash -c 'exec 3<>/dev/tcp/"$1"/"$2"' _ "$host" "$port" 2>/dev/null; then
    echo "SUCCESS: $host is accepting TCP connections on port $port."
    echo "Result: reachable" >> "$LOG_DIR/network-check.log"
    exit 0
else
    echo "WARNING: could not connect to $host on port $port."
    echo "Result: unreachable" >> "$LOG_DIR/network-check.log"
    exit 1
fi
