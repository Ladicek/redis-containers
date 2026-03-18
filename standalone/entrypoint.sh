#!/bin/bash

if [[ "$1" = "redis" ]] ; then
  mkdir -p /redis/data

  touch /redis/redis.conf

  echo "bind 0.0.0.0" >> /redis/redis.conf
  if [[ "$REDIS_TLS_ENABLED" = "yes" ]] ; then
    echo "port 0" >> /redis/redis.conf
  else
    echo "port 6379" >> /redis/redis.conf
  fi

  echo "appendonly yes" >> /redis/redis.conf
  echo "dir /redis/data" >> /redis/redis.conf

  if [[ "$ALLOW_EMPTY_PASSWORD" = "yes" ]] ; then
    echo "protected-mode no" >> /redis/redis.conf
  else
    echo "protected-mode yes" >> /redis/redis.conf
  fi

  if [[ "x$REDIS_PASSWORD" != "x" ]] ; then
    echo "requirepass $REDIS_PASSWORD" >> /redis/redis.conf
  fi

  if [[ "$REDIS_TLS_ENABLED" = "yes" ]] ; then
    echo "tls-port 6379" >> /redis/redis.conf
  fi

  if [[ "x$REDIS_TLS_KEY_FILE" != "x" ]] ; then
    echo "tls-key-file $REDIS_TLS_KEY_FILE" >> /redis/redis.conf
  fi 

  if [[ "x$REDIS_TLS_CERT_FILE" != "x" ]] ; then
    echo "tls-cert-file $REDIS_TLS_CERT_FILE" >> /redis/redis.conf
  fi

  if [[ "x$REDIS_TLS_CA_FILE" != "x" ]] ; then
    echo "tls-ca-cert-file $REDIS_TLS_CA_FILE" >> /redis/redis.conf
  fi

  if [[ "$REDIS_TLS_AUTH_CLIENTS" = "no" ]] ; then
    echo "tls-auth-clients no" >> /redis/redis.conf
  fi

  MOD_PATH=/usr/local/lib/redis/modules
  if [[ -d $MOD_PATH ]] ; then
    for MOD in $(ls $MOD_PATH) ; do
      echo "loadmodule $MOD_PATH/$MOD" >> /redis/redis.conf
    done
  fi

  redis-server /redis/redis.conf &

  bash -c "trap : TERM INT; sleep infinity & wait"
else
  exec "$@"
fi
