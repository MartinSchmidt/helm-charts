# helper-ceph-crd

The idear for this helper chart is that it will facilitate a way to make a storage in k8s where needed, this is why it also contains a storage-class resource.

This is a helper chart that you use as a dependency on you main chart doing something like:
```yaml
dependencies:
- name: helper-ceph-crd
  version: "0.1.0"
  repository: "https://distributed-technologies.github.io/helm-charts/"
  condition: helper-ceph-crd.enabled
```

This is a dependency like the umbrella charts the only different is the condition, this is so that if you want to enable the helper chart you have to consciously enable it.

I would recommend that you do **not** enable the helper chart in the helm-charts repo, since this can have some complications with our current ct-install test.
```yaml
helper-ceph-crd:
  enabled: false
```
<br>

This will mean that your `<service>.yaml` file in yggdrasil, will look like this to begin with
```yaml
helper-ceph-crd:
  enabled: true
```
Every resource that this chart helps with, is a list, so that it's plausible to make multiples of a resource if so desired, therefor if you wish to not create any resources, you will have to set the lists to `[]` in your values file, to not generate the default values.

To disable all resource generation you could write:
```yaml
helper-ceph-crd:
  enabled: true
  cephObjectStores: []
  storageClass: []
  objBucketClaims: []
```

<br>

The chart currently supports creation of the following resources:
* [ceph-object-store-crd](https://github.com/rook/rook/blob/master/Documentation/ceph-object-store-crd.md)<br>
[values.yaml](chart/values.yaml) line 1-24

* [ceph-object-bucket-claim](https://github.com/rook/rook/blob/master/Documentation/ceph-object-bucket-claim.md)<br>
[values.yaml](chart/values.yaml) line 26-34

* [storage-class](https://kubernetes.io/docs/concepts/storage/storage-classes/)<br>
[values.yaml](chart/values.yaml) line 36-41

The ceph resources is just taking the whole `.spec` map and templating that in, so there anything goes.

The storage-class does **not** have a `.spec` to simply template in, in it's entirity, so I have tried to find all the maps that is can use and make them definable as values, should there be one missing, please make a pr on it.

## Hardcoded values
There is currently only one hardcoded value that is applied to all the templates, the annotation `argocd.argoproj.io/sync-options: SkipDryRunOnMissingResource=true`
