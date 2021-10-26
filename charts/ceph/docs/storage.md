<img src="images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

# Storage in Ceph

Ceph has 3 ways of storing data on the cluster. The Ceph file system(CephFS), object-based storage and block-based storage. 

## CephFS
CephFS is a traditional file system interface with POSIX semantics. In order to use CephFS, we first need to create the file system and then provision the storage. This is done by creating a storageclass. More can be found here: https://github.com/rook/rook/blob/master/Documentation/ceph-filesystem.md

## Object-based storage
Object-based storage is efficient when deploying large scale storage systems because of the way it stores data. Object-vased storage systems seperate the object namespace from the underlying storage hardware, which simplifies data migration. More can be found here: https://rook.io/docs/rook/v1.5/ceph-object.html

## Block-based storage
Ceph can be mounted as a thinly provisioned block device. When you write data to Ceph using a block device, Ceph will automatically stripe and replicate the data across the cluster. More can be found here: https://rook.io/docs/rook/v1.5/ceph-block.html

# Our implementation
When deploying Ceph to a Kubernetes cluster, the standard configuration right now is to allow for two ways of storing data. 
First, we create a storage class for block storage, allowing Kubernetes pods to create PVCs. Second, we create a distributed file system called CephFS wherein pods can mount specific paths and thereby use the same storage as other pods. 

