# Next release

- TODO

## 0.1.20

**Release date:** 10 Sep 2025

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-success?color=success&logo=docker)

- 🎉 Successfully implement CHANGELOG.md approach
- ✅ Fix sed command to properly extract release notes content  
- 🚀 Professional release notes now working perfectly
- 📦 Complete workflow automation for chart releases

## 0.1.7

**Release date:** 10 Sep 2025

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm)

A configurable log generator for testing and benchmarking log pipelines

## 📦 Installation

### Using Helm Repository
```bash
helm repo add duyhenryer https://duyhenryer.github.io/charts/
helm install my-log-generator duyhenryer/log-generator --version 0.1.7
```

### Using OCI Registry
```bash
helm install my-log-generator oci://ghcr.io/duyhenryer/charts/log-generator --version 0.1.7
```

## 0.1.6

**Release date:** 10 Sep 2025

- Initial chart release with basic functionality
