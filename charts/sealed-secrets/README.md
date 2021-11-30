# Sealed-secrets





## Dev secret
To enable a constant private key for development purposes one must set the following parameters

    devSecret:
      crt: |
        MIIC2DCCAcCgAwIBAgIBATANBgkqh ...
      key: |
        MIIEpgIBAAKCAQEA7yn3bRHQ5FHMQ ...
    
    sealedSecrets:
      secretName: "dev-secret-key"
      commandArgs:    
        - "--update-status" # Enables updates of status for ArgoCD
        - "--key-renew-period=0" # disables rotation
