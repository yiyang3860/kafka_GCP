#!/bin/bash

docker run --name zookeeper -p 2181:2181  -d wurstmeister/zookeeper
docker run --name kafka --link zookeeper -v /var/run/docker.sock:/var/run/docker.sock -e KAFKA_ADVERTISED_HOST_NAME=192.168.33.200 -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_BROKER_ID=0 -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 -p 9092:9092 -d confluentinc/cp-kafka:5.0.0
docker run --name servo --link kafka -d jessefugitt/docker-autossh autossh -M 0 -g -N -o StrictHostKeyChecking=no -o ServerAliveInterval=5 -o ServerAliveCountMax=1 -i /root/.ssh/id_rsa -R cb10502kafka.serveo.net:80:172.17.0.4:9092 serveo.net
