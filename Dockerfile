FROM debian:buster
LABEL MatejKucera <matej.kucera@atlas.cz>

RUN apt-get update
RUN apt-get -yqq install cron mariadb-client zip
RUN apt-get clean

RUN mkdir /var/backup

COPY backup.sh /backup.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]