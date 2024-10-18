#!/bin/bash

cpu_usage() {
    echo "---CPU Usage---"
    mpstat 1 1 | awk '/Average/ { printf "CPU Usage: %.2f%%\n", 100 - $NF}'
}

memory_usage() {
    echo "---Memory Usage---"
    free -m | awk 'NR==2 {printf "Used: %sMB, Available: %sMB, Usage: %.2f%%\n", $3, $NF, $3*100/($3+$NF)}'
}

disk_usage() {
    echo "---Disk Usage---"
    df -h / | awk 'NR==2 {printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'
}

top_cpu_processes() {
    echo "---Top CPU Processes---"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
}

top_memory_processes() {
    echo "---Top Memory Processes---"
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6
}

os_version() {
    echo "---OS Version---"
    cat /etc/os-release
}

show_uptime() {
    echo "---Uptime---"
    uptime
}

load_average() {
    echo "---Load Average---"
    cat /proc/loadavg
}

main() {
    cpu_usage
    echo
    memory_usage
    echo
    disk_usage
    echo
    top_cpu_processes
    echo
    top_memory_processes
    echo
    os_version
    echo
    show_uptime
    echo
    load_average
}

main