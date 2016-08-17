#!/bin/bash

set -e
config=`curl "consul.service.consul:8500/v1/kv/logstash/config?raw"`

if [ ! -z "$config" ]; then
  echo "$config"
else
  echo "NO CONFIG found at logstash/config"
  exit 1
fi

# Add logstash as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- logstash "$@"
fi

# Run as user "logstash" if the command is "logstash"
if [ "$1" = 'logstash' ]; then
	set -- gosu logstash "$@"
fi

exec "$@"
