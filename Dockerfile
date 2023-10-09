FROM debian:12.1-slim
LABEL name="MySQL Backuper"
LABEL email="matej.kucera@vse.cz"

RUN apt update -yqq && \
    apt install -y mariadb-client zip cron jq && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    touch /etc/cron.d/scheduler

COPY src app
COPY .env /app/.env

WORKDIR /app
ENTRYPOINT [ "/app/entrypoint.sh" ]