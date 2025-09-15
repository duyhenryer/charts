# Helm Chart Repository

[![Helm](https://img.shields.io/badge/helm-%3E%3D3.0-blue)](https://helm.sh)
[![Pages](https://img.shields.io/github/deployments/duyhenryer/charts/github-pages?label=gh-pages)](https://duyhenryer.github.io/charts/)


> 🚀 A personal Helm chart repository, available via **GitHub Pages** or **OCI registry**.

---

## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.


### 📦 Install via Helm repo (GitHub Pages)

```sh
helm repo add duyhenryer https://duyhenryer.github.io/charts/
helm repo update

helm install <release-name> duyhenryer/<chart-name>
```

Uninstall:
```sh
helm uninstall <release-name>
```

### 🐳 Install via OCI registry
```bash
helm install <release-name> oci://ghcr.io/duyhenryer/charts/<chart-name> --version <version>
```
