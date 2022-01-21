#!/bin/bash
set -e

./scripts/install_kubectl.sh
pip install kafka-python

./scripts/wait_for_pod.sh entity-operator
python /scripts/python_producer.py my-cluster-kafka-brokers topic-test-1
python /scripts/python_consumer.py my-cluster-kafka-brokers topic-test-1 10
