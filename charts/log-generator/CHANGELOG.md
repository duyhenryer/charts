# Next release

- Implement VictoriaMetrics-style CHANGELOG.md approach
- Add proper release notes generation from CHANGELOG
- Improve workflow logic for better release management

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
