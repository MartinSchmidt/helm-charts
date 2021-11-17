# Certificates

This CA was created with [`step` CLI](https://smallstep.com/docs/step-cli) per [their documentation](https://smallstep.com/docs/step-cli/basic-crypto-operations#create-and-work-with-x509-certificates).

The root CA was created with:
```sh
$ step-cli certificate create --insecure --no-password --profile root-ca "Proxy Root CA" root_ca.crt root_ca.key
```
and the leaf certificates:
```sh
$ step-cli certificate create <domain> <domain>.crt <domain>.key \
      --insecure --no-password \
      --profile leaf --not-after=87600h \
      --ca ./root_ca.crt --ca-key ./root_ca.key
```
