FROM redis:7.2.5

RUN apt update && apt install gettext-base && apt clean

COPY redis-cluster.tmpl /templates/
COPY entrypoint.sh cluster-add-master.sh cluster-slots-expected-lines.sh /
RUN chmod 755 /entrypoint.sh /cluster-add-master.sh /cluster-slots-expected-lines.sh

EXPOSE 7000 7001 7002 7003 7004 7005 7006 7007

ENTRYPOINT ["/entrypoint.sh"]
CMD ["redis-cluster"]
