# CNI
This helm chart deploys a virtual network in a kubernetes cluster using weave-net. The virtual net is configured in the charts/values.yaml file.

The .yaml file is downloaded from weavenet eith the command  
```wget https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')```    
and editted into a helm chart.
