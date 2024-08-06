#!/bin/bash

if [[ -z "$1" || -z "$2" || -z "$3" ]] ; then
  echo "Expected 3 parameters: first port, last port, the number of lines of 'cluster slots' output"
  exit 1
fi

FIRST_PORT=$1
LAST_PORT=$2
LINES=$3

for PORT in $(seq $FIRST_PORT $LAST_PORT) ; do
  if [[ $(redis-cli -p $PORT cluster slots | wc -l) < $LINES ]] ; then
    exit 1
  fi
done
