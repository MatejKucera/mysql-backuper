#!/bin/sh

HOST=$1
DB=$2
USER=$3
PASS=$4
PORT=$5

echo "Backing: $DB"
DATETIME=$(date "+%Y-%m-%d_%H-%M-%S")

mysqldump -h $HOST -u $USER -p$PASS -P $PORT $DB > /var/backup/$DB-$DATETIME.sql
zip /var/backup/$DB-$DATETIME.zip /var/backup/$DB-$DATETIME.sql -9
rm -f /var/backup/$DB-$DATETIME.sql

find /var/backup/* -mtime +14 -exec rm {} \;