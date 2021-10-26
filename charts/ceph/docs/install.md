<img src="images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

# Install guide

*This guide assumes you are on Ubuntu*

1. Set up a Kubernetes cluster. This can be done on a single node with [Minikube](https://v1-17.docs.kubernetes.io/docs/tasks/tools/install-minikube/) or multiple nodes with [Kubernetes](https://computingforgeeks.com/how-to-setup-3-node-kubernetes-cluster-on-ubuntu-18-04-with-weave-net-cni//).

2. Install Helm by finding the newest release [here](https://github.com/helm/helm/releases). This example uses 3.5.0. After copying the link for Linux amd64, run the following commands: 

```
wget https://get.helm.sh/helm-v3.5.0-linux-amd64.tar.gz
tar -zxvf helm-v3.5.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
```

In order to continue with the rest of the guide, you first need to bootstrap the Rook operator and install all the Custom Resource Definitions. This can be done with the following commands: 
```
git clone https://github.com/rook/rook.git
cd rook/cluster/charts/rook-ceph
helm install -n rook-ceph rook-ceph .
```
Please be aware that if you need to change any settings for the operator, this can be done in the values.yaml file in the rook-ceph directory. Specifically you should set the image-tag. **Do not set it to master.** The master is experimental and not a stable build! Set it to a specific version like v1.5.2. We would also recommend setting the enableDiscoveryDaemon to true. 

3. Deploy the cluster chart with the following command: 

```
helm install -n deployment-namespace deployment-name path-to-chart
```

4. More on how do deploy Helm charts can be found [here](https://helm.sh/docs/helm/helm_install/).

### Your Ceph-cluster should now be deployed. 
