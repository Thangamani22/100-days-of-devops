#!/bin/bash

BACKUP_DIR="/backup"
ZIP_NAME="xfusioncorp_media.zip"
MEDIA_DIR="/var/www/html/media"
BACKUP_SERVER_USER="clint"
BACKUP_SERVER_IP="172.16.238.16"
REMOTE_BACKUP_DIR="/backup"

cd "$BACKUP_DIR" || exit 1

zip -r "$ZIP_NAME" "$MEDIA_DIR"

scp "$ZIP_NAME" ${BACKUP_SERVER_USER}@${BACKUP_SERVER_IP}:${REMOTE_BACKUP_DIR}