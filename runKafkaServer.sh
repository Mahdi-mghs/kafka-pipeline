#create topic
kafka-topics.sh --bootstrap-server 127.0.0.1:9092 --create --topic wikimedia.recentchange --partitions 3 --replication-factor 1

#check LAG status
kafka-consumer-groups.sh  --bootstrap-server 127.0.0.1:9092 --group consumer-opensearch-demo --describe
