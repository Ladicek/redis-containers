FROM redis:7.2.5

RUN apt update && apt install gettext-base && apt clean

COPY redis-cluster.tmpl /templates/redis-cluster.tmpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 7000 7001 7002 7003 7004 7005

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-cluster"]
