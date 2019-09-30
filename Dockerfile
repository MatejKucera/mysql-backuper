FROM debian
LABEL MatejKucera <matej.kucera@atlas.cz>

RUN apt-get update
RUN apt-get -y install cron mysql-client zip
RUN apt-get clean

RUN mkdir /var/backup

COPY backup.sh /backup.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]