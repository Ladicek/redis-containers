#!/bin/bash

if [[ "$1" = "redis-replication" ]] ; then
  FIRST_PORT=7000
  LAST_PORT=7002

  for port in $(seq $FIRST_PORT $LAST_PORT) ; do
    mkdir -p /redis/$port/data

    if [[ "$port" = "$FIRST_PORT" ]] ; then
      PORT=$port envsubst < /templates/redis-master.tmpl > /redis/$port/redis.conf
    else
      PORT=$port envsubst < /templates/redis-replica.tmpl > /redis/$port/redis.conf
    fi

    redis-server /redis/${port}/redis.conf &
  done

  if [[ "$SENTINEL" == "true" ]] ; then
    SENTINEL_FIRST_PORT=5000
    SENTINEL_LAST_PORT=5002

    for port in $(seq $SENTINEL_FIRST_PORT $SENTINEL_LAST_PORT) ; do
      mkdir -p /redis/$port

      PORT=$port envsubst < /templates/redis-sentinel.tmpl > /redis/$port/sentinel.conf

      redis-sentinel /redis/$port/sentinel.conf &
    done
  fi

  bash -c "trap : TERM INT; sleep infinity & wait"
else
  exec "$@"
fi
