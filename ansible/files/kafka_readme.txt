
# Example kafka commands

/opt/kafka/bin/kafka-topics.sh --zookeeper zk1:2181/kafka-cluster-1 --create --topic test_topic --replication-factor 3 --partitions 4 

/opt/kafka/bin/kafka-topics.sh --zookeeper zk1:2181/kafka-cluster-1 --list

/opt/kafka/bin/kafka-topics.sh --zookeeper zk1:2181/kafka-cluster-1 --describe

/opt/kafka/bin/kafka-producer-perf-test.sh --producer-props bootstrap.servers=kafka1:9092 --topic first_topic  --num-records 1000  --record-size 1000 --throughput -1

/opt/kafka/bin/kafka-consumer-perf-test.sh --broker-list=kafka1:9092 --topic first_topic  --messages=1000 

