
# Assignment 1: Linux, Bash, Networking and Git

## Overview

This project contains Bash scripts for system information,
disk usage monitoring, and TCP connectivity testing.

## Requirements

- Linux or a compatible Bash environment
- Bash
- Standard Linux utilities
- Git

## Scripts

### system-info.sh

Displays the hostname, current user, Linux kernel, and uptime.
Writes a record to logs/system-info.log.

Run:

    ./system-info.sh

### disk-check.sh

Checks disk usage against a threshold from 1 to 100.

Run:

    ./disk-check.sh 80 /
    ./disk-check.sh 90 /home

Exit codes:
- 0: Disk usage is below the threshold
- 1: Disk usage has reached or exceeded the threshold
- 2: Invalid input or an error

### network-check.sh

Tests TCP connectivity to a host and port.

Run:

    ./network-check.sh localhost
    ./network-check.sh example.com 443

Exit codes:
- 0: Connection succeeded
- 1: Connection failed
- 2: Invalid input or a missing requirement

## Logging

Logs are stored in the logs/ directory.

## Permissions

Scripts are executable with chmod +x.
