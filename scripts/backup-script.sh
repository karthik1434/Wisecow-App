#!/bin/sh

# ================================
# Automated Backup Script
# ================================

# Configurations
SOURCE_DIR="/vagrant"                       # directory to back up
BACKUP_NAME="backup-$(date +%Y%m%d-%H%M%S).tar.gz"
BACKUP_PATH="/tmp/$BACKUP_NAME"

REMOTE_USER="vagrant"
REMOTE_HOST="192.168.56.20"                 # remote VM/server IP
REMOTE_DIR="/home/vagrant/backups"

LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Create log file if missing
if [ ! -f "$LOG_FILE" ]; then
  touch "$LOG_FILE"
  chmod 644 "$LOG_FILE"
fi

echo "[$TIMESTAMP] Starting backup of $SOURCE_DIR..." | tee -a "$LOG_FILE"

# Step 1: Create compressed archive
tar -czf "$BACKUP_PATH" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"
if [ $? -ne 0 ]; then
  echo "[$TIMESTAMP] ❌ Failed to create archive $BACKUP_PATH" | tee -a "$LOG_FILE"
  exit 1
fi

# Step 2: Copy to remote server
scp "$BACKUP_PATH" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/"
if [ $? -ne 0 ]; then
  echo "[$TIMESTAMP] ❌ Failed to transfer backup to $REMOTE_HOST:$REMOTE_DIR" | tee -a "$LOG_FILE"
  rm -f "$BACKUP_PATH"
  exit 1
fi

# Step 3: Cleanup
rm -f "$BACKUP_PATH"

echo "[$TIMESTAMP] ✅ Backup successful! File stored at $REMOTE_HOST:$REMOTE_DIR/$BACKUP_NAME" | tee -a "$LOG_FILE"
