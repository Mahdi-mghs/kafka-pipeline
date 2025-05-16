<!--
===========================
  Wikimedia→Kafka→OpenSearch
===========================

An end‑to‑end real‑time data‑streaming pipeline ingesting Wikimedia event streams into Apache Kafka and indexing into OpenSearch for live dashboards.
-->
# Wikimedia Kafka → OpenSearch Pipeline

This repository contains everything you need to ingest the Wikimedia recent‑changes feed into Kafka, then consume and index it into OpenSearch for real‑time analytics and dashboards.

[data_flow](docs/data_flow.png)

## 📊 Dashboard Preview

Below is a preview of the live OpenSearch dashboard visualizing edit activity, top pages, and user statistics in real time:

![OpenSearch Dashboard Preview](docs/simpleRecord.mp4)

---

## 🚀 Features

- **High‑throughput Kafka Producer**  
  – Batching, linger, and Snappy compression to maximize throughput.  
- **Flexible Consumption**  
  – Java consumer or Kafka Connect sink to OpenSearch.  
- **Dockerized**  
  – `docker-compose.yml` for bringing up OpenSearch, Kafka Connect, and dependencies in one command.  
- **KRaft‑mode Kafka**  
  – Zero‑Zookeeper, KRaft single‑node cluster via `kafkaManage.sh`.  
- **Auto topic creation**  
  – Topics created with 3 partitions and 1 replica, named `wikimedia.percentage`.  
- **Real‑time Analytics**  
  – OpenSearch index templates & Kibana‑style dashboards out of the box.

---

## 🏗️ Architecture

1. **Wikimedia Event Stream** (Producer)  
   - Connects to [Wikimedia EventStreams API](https://wikitech.wikimedia.org/wiki/EventStreams).  
   - Publishes JSON events to Kafka topic `wikimedia.percentage`.  
2. **Apache Kafka** (Broker)  
   - KRaft mode, 3 partitions × 1 replica.  
3. **OpenSearch Sink** (Consumer)  
   - Either via custom Java consumer or Confluent Kafka Connect OpenSearch sink.  
   - Writes into index `wikimedia-changes-YYYY.MM.dd`.  
4. **OpenSearch Dashboards**  
   - Pre‑built visualizations and dashboards for real‑time monitoring.

---

## 🔧 Prerequisites

- Java 17+ & Maven  
- Docker & Docker Compose  
- Bash (for `kafkaManage.sh`)  

---

## 🛠️ Setup

1. **Clone the repo**  
   ```bash
   git clone https://github.com/Mahdi-mghs/kafka-pipeline
   cd kafka-pipeline
   chmod +x kafkaManage.sh
2. **Run kafka and consumer**
   ```bash
   ./kafkaManage.sh start
   ```
   this will:
   - Launch a single‑node KRaft Kafka broker
   - Start OpenSearch & OpenSearch Dashboards via Docker Compose
   - Prompt to choose between Kafka Connect or Java consumer


