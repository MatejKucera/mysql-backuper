#!/bin/sh

# Acquire the arguments
HOST=$1
DB=$2
USER=$3
PASS=$4
PORT=$5

# Source the .env
. /app/.env

# Set the datetime in filename format
DATETIME=$(date "+%Y-%m-%d_%H-%M-%S")

# Set the filename (concatenate the hostname, database name and datetime)
FILENAME=${HOST}-${DB}-${DATETIME}

# Dump the database
mysqldump -h $HOST -u $USER -p$PASS -P $PORT $DB > /app/output/$FILENAME.sql

# Compress the database dump
zip -j /app/output/$FILENAME.zip /app/output/$FILENAME.sql -${COMPRESSION_LEVEL}

# Remove the uncompressed database dump
rm -f /app/output/$FILENAME.sql

# Remove the old backups
find /app/output/* -mtime +${BACKUP_RETENTION_DAYS} -exec rm {} \;