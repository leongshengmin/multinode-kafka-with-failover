#!/usr/bin/env bash

# cleanup 
# /usr/local/bin/kafka-topics --delete \
#     --topic replicated-topic \
#     --zookeeper localhost:2181

# create topic
/usr/local/bin/kafka-topics --create \
    --topic replicated-topic \
    --replication-factor 3 \
    --partitions 5 \
    --zookeeper localhost:2181
    

