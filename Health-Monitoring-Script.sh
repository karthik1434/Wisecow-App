#!/bin/sh

# ================================
# Linux System Health Monitor (POSIX sh compatible)
# ================================

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
PROC_THRESHOLD=300

# Log file
LOG_FILE="/var/log/system_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Create log file if missing
if [ ! -f "$LOG_FILE" ]; then
  touch "$LOG_FILE"
  chmod 644 "$LOG_FILE"
fi

# Get system stats
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)   # idle -> used
MEM_USAGE=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100.0}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
PROC_COUNT=$(ps -e --no-headers | wc -l)

ALERTS=""

# Check CPU
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
  ALERTS="${ALERTS}[ALERT] High CPU Usage: ${CPU_USAGE}%% (Threshold: ${CPU_THRESHOLD}%%)\n"
fi

# Check Memory
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
  ALERTS="${ALERTS}[ALERT] High Memory Usage: ${MEM_USAGE}%% (Threshold: ${MEM_THRESHOLD}%%)\n"
fi

# Check Disk
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  ALERTS="${ALERTS}[ALERT] High Disk Usage: ${DISK_USAGE}%% (Threshold: ${DISK_THRESHOLD}%%)\n"
fi

# Check Processes
if [ "$PROC_COUNT" -gt "$PROC_THRESHOLD" ]; then
  ALERTS="${ALERTS}[ALERT] High Process Count: ${PROC_COUNT} (Threshold: ${PROC_THRESHOLD})\n"
fi

# Write to console & log
if [ -n "$ALERTS" ]; then
  printf "[$TIMESTAMP] System Health Alerts:\n$ALERTS" | tee -a "$LOG_FILE"
else
  echo "[$TIMESTAMP] System is healthy ✅" | tee -a "$LOG_FILE"
fi
