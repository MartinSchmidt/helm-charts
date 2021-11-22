# services-kafka
A repo for a Kafka helm chart. The charts sets up a [Strimzi](https://strimzi.io/) Kafka operator in kubernetes and exposes functionality through kubernetes Custom Resource Definitions. 

A quickstart guide to Strimzi can be found [here](https://strimzi.io/docs/operators/latest/quickstart.html).

# Examples 
Example of the Strimzi resources for Kafka can be found [here](https://github.com/strimzi/strimzi-kafka-operator/tree/0.22.1/examples)


# Testing 
For testing the helm chart we use [ Kubernetes In Docker ](https://kind.sigs.k8s.io/). We create a 3 node cluster with the command `kind create cluster -config test/kind.yaml`. We install a loadbalancer so that we can use ips to acces the brokers when we install the Kafka cluster. A loadbalancer can be installed with: 
``` 
helm install --set ipRangeStart=172.19.0.10 \
            --set ipRangeStop=172.19.0.20  \
            --set imagePullPolicy=Always \
            lb https://github.com/distributed-technologies/services-loadbalancer/releases/download/v0.1.3/default.mukube-loadbalancer-v0.1.3.tgz 
```
The ip interval for the loadbalancer should match the one controlled by docker. This can be checked with the command: `docker network inspect -f '{{.IPAM.Config}}' kind` 
Then we install our chart with ` helm install test-kafka chart/ --set env=test`. 


# Monitoring 

Kafka Strimzi does not export metrics by default and needs to have a exporter installed from this chart https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus-kafka-exporter/

# KafkaDB - ksql

The helm chart enables and exposes a KafkaDB server which makes it possible to create Kafka Streams and Tables that can be queried with ksql

Some examples are found in [docs/ksql-examples.md](docs)

# WARNING

Different versions of ksqlDB and ksqlBD-cli are highly incompatible. Make sure you always use exactly the same version of the server and the cli.

To execute the queries to the ksql server run a ksql-CLI pod:

`kubectl run my-shell --rm -i --tty --image confluentinc/cp-ksqldb-cli:6.1.0 -- http://test-kafka-cp-ksql-server:8088`
