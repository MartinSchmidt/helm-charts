#!/bin/bash
pip install kafka-python
python /scripts/python_producer.py my-cluster-kafka-brokers topic-test-1
python /scripts/python_consumer.py my-cluster-kafka-brokers topic-test-1 10
