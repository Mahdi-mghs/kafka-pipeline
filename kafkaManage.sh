#!/bin/bash

# Get the directory where this script resides
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get kafka directory
KAFKA_BIN_DIR=$(dirname $(which kafka-storage.sh))
KAFKA_HOME=$(dirname "$KAFKA_BIN_DIR")

# Create UUID
Uuid=$(kafka-storage.sh random-uuid)

case "$1" in
    stop)
        echo "Stopping Kafka..."
        kafka-server-stop.sh
        ;;
    *)

        # Format storage using PATH-based command
        kafka-storage.sh format -t "$Uuid" -c "$KAFKA_HOME/config/kraft/server.properties"

        # Run Server in background with & and add brief sleep
        echo "Starting Kafka server (logs: kafka-server.log)..."
        kafka-server-start.sh "$KAFKA_HOME/config/kraft/server.properties" > kafka-server.log 2>&1 &
        sleep 5  # Wait for server to initialize

        # Create topic
        echo "Creating topic..."
        kafka-topics.sh --bootstrap-server 127.0.0.1:9092 --create \
                        --topic wikimedia.recentchange \
                        --partitions 3 \
                        --replication-factor 1

        # Interactive prompt for sink connector
        read -p "Do you want to start the OpenSearch sink connector? [y/N] " -n 1 -r
        echo  

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [[ -f "${SCRIPT_DIR}/connect-standalone.properties" && 
                  -f "${SCRIPT_DIR}/connect-opensearch.properties" ]]; then
                echo "Starting OpenSearch sink connector..."
                connect-standalone.sh \
                    "${SCRIPT_DIR}/connect-standalone.properties" \
                    "${SCRIPT_DIR}/connect-opensearch.properties" > connector.log 2>&1
            else
                echo "Error: Properties files missing in script directory!"
                exit 1
            fi
        fi
        # Check LAG
        echo "you can run"
        echo "kafka-consumer-groups.sh --bootstrap-server 127.0.0.1:9092 --group consumer-opensearch-demo --describe"
        echo
        echo "command to check LAG, IF you currently use opensearch-sink connector try this one :"
        echo "kafka-consumer-groups.sh --bootstrap-server 127.0.0.1:9092 --group connect-opensearch-sink --describe"
        ;;
esac
