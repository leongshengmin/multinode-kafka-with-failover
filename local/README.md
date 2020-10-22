This creates:

- 1 shared zookeeper instance
- 3 kafka nodes
- 1 consumer (with knowledge of multiple kafka brokers)
- 1 producer (with knowledge of multiple kafka brokers)
- 1 topic (replicated and distributed across all brokers in case a broker fails)

Run the following from the `local` directory in separate terminal windows.

1. Startup a single zookeeper instance

```
/usr/local/bin/zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties
```

2. In separate 3 terminal windows, startup each kafka broker (kafka-0,kafka-1,kafka-2)

```
./startup-kafka/startup-kafka-0.sh
```

3. Create the replicated topic

```
./create-replicated-topic.sh
```

4. Startup the consumer

```
./consumer.sh
```

5. Startup the producer

```
./producer.sh
```

6. Describe topics

```
watch /usr/local/bin/kafka-topics --describe \
    --topic replicated-topic \
    --zookeeper localhost:2181
```

Notice that the topics are replicated over 3 kafka brokers (0, 1, 2); also notice that all brokers (0, 1, 2) are leaders of a partition.

### Triggering broker failover

7. Kill kafka broker 0. Press ctrl+c in the terminal window running kafka-0.

8. In the terminal window describing the kafka topics, observe that the partitions are now only distributed over brokers (1, 2).

9. Send a message via the producer. Verify that the consumer still receives the message.
