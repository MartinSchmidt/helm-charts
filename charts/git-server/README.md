# services-git-server
This helm chart sets up a git server through a nginx server and exposes it with a Kubernetes service. 

To make the Git server HA, mount a shared PVC e.g. in Ceph and increase the `replicaCount`. 
