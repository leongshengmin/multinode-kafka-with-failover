#!/usr/bin/env bash

# pass in multiple kafka brokers so that consumer can learn about other brokers if one fails
/usr/local/bin/kafka-console-producer \
    --topic replicated-topic \
    --broker-list localhost:9093,localhost:9094
    