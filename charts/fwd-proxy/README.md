# Forward proxy

This helm chart sets up a forward proxy for a cluster. The proxy redirects http requests to local services. This is usefull when deploying a kubernetes cluster in an air-gapped environment. 

The proxy deploys an Envoyproxy server and an Nginx server. The Envoyproxy is only used in order to terminate HTTP CONNECT requests, which nginx cannot do at the moment. The nginx server handles forwarding of requests.

The forward proxy has a hard dependency on a git-server, a http-server serving as a helm repository, and an image registry. The services need to be avialable for the nginx server to start.
