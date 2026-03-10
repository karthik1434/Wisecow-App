#!/bin/sh

# ================================
# Application Health Checker
# ================================

APP_URL="http://wisecow.local"   # change to your app URL
LOG_FILE="/var/log/app_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Create log file if missing
if [ ! -f "$LOG_FILE" ]; then
  touch "$LOG_FILE"
  chmod 644 "$LOG_FILE"
fi

# Check application
STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$APP_URL")

if [ "$STATUS_CODE" -ge 200 ] && [ "$STATUS_CODE" -lt 400 ]; then
  echo "[$TIMESTAMP] ✅ Application is UP (HTTP $STATUS_CODE)" | tee -a "$LOG_FILE"
else
  echo "[$TIMESTAMP] ❌ Application is DOWN (HTTP $STATUS_CODE)" | tee -a "$LOG_FILE"
fi
