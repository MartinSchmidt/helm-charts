<img src="docs/images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

# Ceph-Helm repository

## About

This is the repository for Energinets Helm chart that deploys our Ceph cluster. The Helm chart can be found in the chart/ directory. Rook is used as the storage administrator in this project and the deployment files that are used are therefore configured files from the rook.io repository. 

When deployed, this project will bootstrap the Rook operator which in turn will create all the necessary deployments for the Ceph cluster to be fully operationel on your kubernetes cluster. The files have been pre-configured to fit the requirements of this project but are all well commented and easily configured by others. You can find a guide on how to install [here](docs/install.md)

## Structure

This is the folder structure of this repository

```
ceph-helm
│   README.md
│   LICENSE   
│
└───docs
│   │   doc1.md
│   │   doc2.md
│   └───images
│       │   image1.yaml
│       │   image2.yaml
│       │   ...
│
└───chart
    │   values.yaml
    │   Chart.yaml
    │   README.md
    │
    └───templates
        │   template1.yaml
        │   template2.yaml
        │   ...
```
