# Helm chart repository

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:


For OCI Registry:
```shell
# create a token, login to ghcr.io with
helm registry login ghcr.io

helm pull oci://ghcr.io/duyhenryer/charts/cloudflared --version 0.2.1
```

For Helm Registry:
```sh
helm repo add duyhenryer https://duyhenryer.github.io/charts/
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.

To install the `cloudflared` chart:

```sh
helm install cloudflared duyhenryer/cloudflared 
```

To uninstall the chart:

```sh
helm delete cloudflared
```
