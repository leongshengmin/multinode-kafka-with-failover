#!/usr/bin/env bash

# pass in multiple kafka brokers so that consumer can learn about other brokers if one fails
/usr/local/bin/kafka-console-consumer \
    --topic replicated-topic \
    --bootstrap-server localhost:9094,localhost:9093,localhost:9092 \
    --from-beginning
