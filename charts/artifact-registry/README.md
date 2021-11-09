# services-artifact-registry
A registry setup for both helm charts and container images.


Add the registry with the name `local-helm-registry` use command:  
`helm repo add local-helm-registry http://<IP>:<PORT>`

If the index.yaml file is present on the fileserver you should be able to install the helm chart:  
`helm install local-helm-registry/chart --generate-name`
