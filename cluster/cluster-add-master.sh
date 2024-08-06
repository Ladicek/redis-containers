#!/bin/bash

if [[ -z "$1" ]] ; then
  echo "Expected one parameter, the port number"
  exit 1
fi

if [[ -d "/redis/$1" ]] ; then
  echo "Directory /redis/$1 already exists"
  exit 1
fi

PORT=$1

mkdir -p /redis/$PORT/data
PORT=$PORT envsubst < /templates/redis-cluster.tmpl > /redis/$PORT/redis.conf

redis-server /redis/$PORT/redis.conf | tee /tmp/$PORT.log &

sleep 2

redis-cli --cluster add-node 127.0.0.1:$PORT 127.0.0.1:7000 &

until grep -q 'Cluster state changed: ok' /tmp/$PORT.log ; do
  sleep 1
done
