# mukube-ingress

This Helm chart deploys Traefik as an ingress controller in kubernetes.

## Providers

Only the provider, kubernetesingress, is enabled so only routes defined in an Ingress resource gets created.
An example ingress could look like:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: test-ingress
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: web
spec:
  ingressClassName: "mukube-ingress"
  rules:
    - host: test.example.com
      http:
        paths:
          - path: /test
            pathType: Prefix
            backend:
              service:
                name: test-service
                port:
                  number: 8080
```
This will create a route from the entrypoint *web* to port *8080* on the service *test-service* 
when the request asks for the host *test.example.com* with the path prefix */test*

More information about which annotations can be put on ingresses, look here:
<https://doc.traefik.io/traefik/routing/providers/kubernetes-ingress/#on-ingress>

## DaemonSet or Deployment
This chart deploys Traefik as a DaemonSet because for our use it seems reasonable to have one pod on each node.
If finer grained scaling control is needed, it would not be  hard to change it  to a Deployment with a ReplicaSet.
