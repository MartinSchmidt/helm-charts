<img src="images/Energinet-logo.png" width="250" style="margin-bottom: 3%">

# Design choices
This documents the different design choices we have made during development of the platform. It benefits both new developers who would like to fork the repo as well as ourselves to remember why we ended up where we did. 

## Helm
It was difficult to settle on a Helm chart structure for our rook-ceph charts. In the initial version of the chart, we added the cluster CRs to the original Rook operator chart. That looked like this: 

```
───chart
    │   values.yaml
    │   Chart.yaml
    │   README.md
    │
    └───templates
        │   crd.yaml
        │   operator.yaml
        │   cluster.yaml
        │   ...
```
This did not work because the CRDs need to be created before any instances of them can be created by Kubernetes and this does not happen when they are all in the same template folder. 

Helm allows for CRDs to be created prior to any CRs by putting the CRDs into their own folder called crds:

```
───chart
    │   values.yaml
    │   Chart.yaml
    │   README.md
    │
    └───templates
    │   │   operator.yaml
    │   │   cluster.yaml
    │   │   ...
    │
    └───crds
        │   crd1.yaml
        │   crd2.yaml
        │   ...
```


This was one of the solutions shown in the [crds documentation for Helm](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/). However, this proved to extremely unflexible as we could not upgrade or delete any of the CRDs which would make updating pretty much impossible. 

I discussed this with some of the Rook developers here: <https://github.com/rook/rook/issues/6776>. At this point there is still not an accepted structure of the helm charts for Rook. After some time, an update to Rook had to be performed. This is done easily with Helm by just upgrading the helm chart. This posed us with another consideration when choosing the structure of our Helm charts: What is the structure that lets us perform Rook updates the easiest? The answer was to keep the Rook helm chart structure the way they intended and create our own helm chart for the cluster CRs. By doing this we first of all eliminate the need to have the CRDs as well as the operator chart in this repo. Second of all, it makes sure we can always pull from Rook to get the newest version for updates and there will never be updated to an outdated version of Rook. 

This means the final structure looks like this: 
```
───chart
    │   values.yaml
    │   Chart.yaml
    │   README.md
    │
    └───templates
    │   │   cluster1.yaml
    │   │   cluster2.yaml
    │   │   ...
```
