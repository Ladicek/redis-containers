FROM redis:7.2.5

RUN apt update && apt install gettext-base && apt clean

COPY redis-master.tmpl redis-replica.tmpl redis-sentinel.tmpl /templates/
COPY entrypoint.sh /
RUN chmod 755 /entrypoint.sh

EXPOSE 7000 7001 7002 5000 5001 5002

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-replication"]
