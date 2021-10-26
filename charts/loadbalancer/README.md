# mukube-loadbalancer
This helm chart enabled kubernetes loadbalancer services using metallb. The loadbalancer is configured in the charts/values.yaml file. The loadbalancer uses arp to broadcast the ip addresses of the lservices. 

The helm chart has been generated with inspiration from the [MetalLB instalation guide](https://metallb.universe.tf/installation/).

### Testing
The workflow ```test_deploy``` deploys the load-balancer in a KinD cluster using a test values.yaml file in the ```test``` folder.
The availible ips for the loadbalancer is based on the network supplied by docker and kind ```docker network inspect -f '{{.IPAM.Config}}' kind```.