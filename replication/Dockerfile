FROM redis:7.2.5

RUN apt update && apt install gettext-base && apt clean

COPY redis-master.tmpl /templates/redis-master.tmpl
COPY redis-replica.tmpl /templates/redis-replica.tmpl
COPY redis-sentinel.tmpl /templates/redis-sentinel.tmpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 7000 7001 7002 5000 5001 5002

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-replication"]
