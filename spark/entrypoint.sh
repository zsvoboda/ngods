#!/bin/bash

mkdir -p /tmp/spark-events

start-master.sh -p 7077 --webui-port 8081
start-worker.sh spark://spark-iceberg:7077 --webui-port 8082
start-history-server.sh

# Entrypoint, for example notebook, pyspark or spark-sql
if [[ $# -gt 0 ]] ; then
    eval "$1"
fi
