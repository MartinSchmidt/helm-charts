# service-haproxy
A helm chart for deploying a haproxy application that portforwards and loadbalances connections to the kubernetes api-server.

The helm chart deploys a haproxy pod on all master nodes and listens for trafic on a port, that is then round robin loadbalanced to all other configured endpoints.

The haproxy server is configured in the `cm-haproxy.yaml` config map.  
