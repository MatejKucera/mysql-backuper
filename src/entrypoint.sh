#!/bin/sh

# Read the JSON file into a variable
json_data=$(cat /app/config.json)

# Source the .env file
. /app/.env

# Parse the JSON array and iterate over each object
for entry in $(echo "${json_data}" | jq -c '.[]'); do

    # Extract values from the JSON object
    hostname=$(echo "${entry}" | jq -r '.hostname')
    port=$(echo "${entry}" | jq -r '.port')
    database=$(echo "${entry}" | jq -r '.database')
    username=$(echo "${entry}" | jq -r '.username')
    password=$(echo "${entry}" | jq -r '.password')
    compression=$(echo "${entry}" | jq -r '.compression')

    # Create the cron job and append it to single file
    echo "${SCHEDULE} sh /app/database_backup.sh ${hostname} ${database} ${username} ${password} ${port} ${COMPRESSION_LEVEL} ${BACKUP_RETENTION_DAYS} > /app/log/cron.log" >> /etc/cron.d/scheduler

done

# Set the cron job permissions
chmod 0644 /etc/cron.d/scheduler
# Apply the cron job
crontab /etc/cron.d/scheduler
# Create the log file
touch /var/log/cron.log
# Run the cron
/usr/sbin/cron -f
