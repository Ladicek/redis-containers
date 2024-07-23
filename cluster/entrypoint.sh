#!/bin/bash

if [[ "$1" = "redis-cluster" ]] ; then
  IP=0.0.0.0
  FIRST_PORT=7000
  MASTERS=3
  REPLICAS_PER_MASTER=1

  LAST_PORT=$(($FIRST_PORT + $MASTERS * (1 + $REPLICAS_PER_MASTER) - 1))

  for port in $(seq $FIRST_PORT $LAST_PORT) ; do
    mkdir -p /redis/$port/data

    PORT=$port envsubst < /templates/redis-cluster.tmpl > /redis/$port/redis.conf
    nodes="$nodes $IP:$port"

    redis-server /redis/${port}/redis.conf &
  done

  sleep 2

  eval redis-cli --cluster create "$nodes" --cluster-yes --cluster-replicas $REPLICAS_PER_MASTER

  bash -c "trap : TERM INT; sleep infinity & wait"
else
  exec "$@"
fi
