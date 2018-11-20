FROM renskiy/cron
RUN apt update && apt -y install calibre
COPY cron /etc/cron.d/rss2kindle
COPY . /rss2kindle
RUN chmod 0755 /rss2kindle/entrypoint.sh
ENTRYPOINT ["/rss2kindle/entrypoint.sh"]
CMD ["start-cron"]
