# Next release

- TODO

## 0.1.2

**Release date:** 10 Sep 2025

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-success?color=success&logo=docker)

- 🚀 fix correctly `arg` in value file.

## 0.1.1

**Release date:** 10 Sep 2025

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-success?color=success&logo=docker)


- 🚀 Initial chart release with basic functionality

## 📦 Installation

### Using Helm Repository
```bash
helm repo add duyhenryer https://duyhenryer.github.io/charts/
helm install my-log-generator duyhenryer/log-generator --version 0.1.1
```

### Using OCI Registry
```bash
helm install my-log-generator oci://ghcr.io/duyhenryer/charts/log-generator --version 0.1.1
```