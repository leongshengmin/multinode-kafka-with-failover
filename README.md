## Running multi-node kafka cluster on Docker

File directory structure:

- `local`: contains guide on how to run zookeeper and kafka locally on host (without docker)
- `single-host`: contains `docker-compose.yml` for running zookeeper and kafka as containers using docker

### Instructions for running zookeeper and kafka using docker & testing broker failover:

```
# startup the containers (zookeeper, 3 kafka brokers)
docker-compose up

# exec into one of the brokers to get an interactive shell
docker exec -it kafka2 bash

# create a replicated topic with replication factor 3 and with 5 partitions
kafka-topics \
  --create \
  --zookeeper zookeeper:2181 \
  --replication-factor 3 \
  --partitions 5 \
  --topic replicated-topic

# start a consumer which consumes from the replicated topic
# a list of bootstrap servers are supplied for failover purposes
# i.e. if one of the servers die, the consumer can still get the IPs of other reachable brokers
kafka-console-consumer \
    --topic replicated-topic \
    --bootstrap-server kafka1:9092,kafka2:9093,kafka3:9095 \
    --from-beginning

# get another interactive shell
docker exec -it kafka2 bash

# start a producer which produces to the replicated topic
kafka-console-producer \
    --topic replicated-topic \
    --broker-list kafka1:9092,kafka2:9093,kafka3:9095

# get another interactive shell
docker exec -it kafka3 bash

# describe the topics
# observe that the partitions are distributed over kafka1, kafka2, kafka3
kafka-topics --describe \
  --topic replicated-topic \
  --zookeeper zookeeper:2181

# now kill one of the brokers
docker kill kafka1

# describe the topics again
# observe that the partitions are now distributed over the remaining brokers i.e. kafka2, kafka3
kafka-topics --describe \
  --topic replicated-topic \
  --zookeeper zookeeper:2181

# verify that failover succeeded
# send a message via the console producer
# check that the console consumer prints the message sent
```
