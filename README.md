# Kafka-pipeline

This repository hosts the **Real-Time Analytics** module, a key component of a larger data ingestion and processing system. In this module, we leverage live streaming data from Wikimedia, process it using Kafka, and feed it to OpenSearch for real-time analytics. Note that this module is part of an evolving ecosystem—future releases will include additional consumers targeting different use cases.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)

## Overview

This module is dedicated solely to providing real-time analytical capabilities for data streamed from Wikimedia. Here’s a high-level overview:

- **Producer (Java):**  
  A Java application collects streaming data from Wikimedia and pushes messages to a Kafka topic.

- **Message Queue (Kafka):**  
  Acts as the intermediary, buffering and distributing messages reliably.

- **Consumer (OpenSearch):**  
  This component pulls data from Kafka and indexes it into OpenSearch, where a real-time dashboard visualizes the analytic insights.

- **Optimization (Kafka Connect Sink):**  
  To improve data ingestion speed into OpenSearch, we have configured a Kafka Connect Sink. This significantly enhances the performance and responsiveness of the analytics dashboard.

- **Integration & Deployment:**  
  - The Consumer is orchestrated using Docker Compose to ensure ease of deployment.
  - A Bash script is provided to run both Producer and Consumer together.
  - A demo GIF of the OpenSearch dashboard is included to showcase the real-time analytics interface.

## Architecture

The overall flow for the Real-Time Analytics module is as follows:

1. **Data Collection:**  
   - The Java-based Producer connects to Wikimedia's open streaming API to fetch live data.
   - This data is published to a Kafka topic.

2. **Message Distribution:**  
   - Kafka ensures that messages are reliably queued and distributed to the subscribed consumers.

3. **Data Processing & Analytics:**  
   - The OpenSearch Consumer retrieves data from Kafka.
   - With the use of Kafka Connect Sink, data ingestion into OpenSearch is optimized.
   - The data is then indexed in OpenSearch for real-time analytics.

4. **Visualization:**  
   - The OpenSearch dashboard (illustrated through an included GIF) allows users to visualize and analyze the data as it flows in.

## Prerequisites

Ensure you have the following installed on your environment before proceeding:

- **Java** (JDK 17 or later)
- **Apache Kafka**
- **Docker** and **Docker Compose**
- **Bash** (for running the startup script)
- Reliable network access to Wikimedia’s streaming API
