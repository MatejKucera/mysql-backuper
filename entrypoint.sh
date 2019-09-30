#!/bin/sh

SCH=$(echo "${SCHEDULE}" | sed -e 's/^"//' -e 's/"$//')

echo $SCH

echo "${SCH} sh /backup.sh ${HOSTNAME} ${DATABASE} ${USERNAME} ${PASSWORD} ${PORT} >> /var/log/cron.log" >  /etc/cron.d/scheduler
chmod 0644 /etc/cron.d/scheduler
crontab /etc/cron.d/scheduler
touch /var/log/cron.log

/usr/sbin/cron -f
echo "Cron started. DB: $database"