#!/bin/bash

if [[ "$1" = "redis-cluster" ]] ; then
  IP=127.0.0.1
  FIRST_PORT=7000
  MASTERS=3
  REPLICAS_PER_MASTER=1

  LAST_PORT=$(($FIRST_PORT + $MASTERS * (1 + $REPLICAS_PER_MASTER) - 1))

  NODES=""
  for PORT in $(seq $FIRST_PORT $LAST_PORT) ; do
    mkdir -p /redis/$PORT/data

    PORT=$PORT envsubst < /templates/redis-cluster.tmpl > /redis/$PORT/redis.conf
    NODES="$NODES $IP:$PORT"

    redis-server /redis/$PORT/redis.conf &
  done

  sleep 2

  redis-cli --cluster create $NODES --cluster-yes --cluster-replicas $REPLICAS_PER_MASTER

  bash -c "trap : TERM INT; sleep infinity & wait"
else
  exec "$@"
fi
