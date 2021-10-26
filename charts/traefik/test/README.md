# Ingress Example

This is an example Helm chart that creates a pod that runs <https://github.com/traefik/whoami> 
and an ingress that uses the ingress controller created by the main chart

This chart can be installed to a cluster by running:

```shell script
helm install -f values.yaml .
```

from the chart folder. This will create a pod that runs traefik/whoami 
and an ingress route from the entrypoint *web* for request on *test.localhost/* to the service.

To see if it works, make sure that a local port is forwarded to the entrypoint port on the cluster.
If the entrypoint port is *30080* this can be done with:

```shell script
ssh -N -L 80:localhost:30080 <cluster-ip>
```

Then make a request to *test.localhost/* and if it returns with information about the request, 
the ingress works.  