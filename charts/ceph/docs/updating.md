<img src="images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

General guidelines on how to update Rook or Ceph can be found here: https://github.com/rook/rook/blob/master/Documentation/ceph-upgrade.md

# Cluster health
It is important that the cluster health is health_ok before proceeding with any updates to rook or ceph. Without that, the cluster can degrade to a non-functional state. 

# Updating Rook version
In order to update the Energinet version of rook, you need to update the CRDs and the Operator. This can be done using the helm chart that rook maintains, as long as the chart only creates the CRDs and bootstraps the operator. 

It is important to change certain configurations from the helm chart so it matches the configuration we are using in production. These configurations can be found in the values.yaml file. It is especially important to update the rook image version and not use the master version. 

To update the rook version, copy the helm chart to a master node, change directory into the chart and write: 
```
helm upgrade -n rook-ceph rook-ceph .
```
After this, rook should update the rook version on the different pods.

# Updating Ceph version
Updating ceph is as easy as providing the new image to values.yaml and upgrading the ceph cluster chart: 

```
helm upgrade -n rook-ceph rook-ceph-cluster .
```

After this, rook should update the ceph version on the different pods. 
