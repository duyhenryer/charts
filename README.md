# Helm Charts Repository

A collection of production-ready Helm charts for Kubernetes deployments.

## Prerequisites

- [Helm](https://helm.sh) 3.x installed
- Kubernetes cluster access
- Please refer to Helm's [documentation](https://helm.sh/docs) to get started

## Repository Setup

### Option 1: Helm Registry (Recommended)

```bash
# Add the repository
helm repo add duyhenryer https://duyhenryer.github.io/charts/

# Update repository index
helm repo update
```

### Option 2: OCI Registry

```bash
# Login to GitHub Container Registry
helm registry login ghcr.io

# Charts are available at: oci://ghcr.io/duyhenryer/charts/<chart-name>
```

## Available Charts

| Chart | Version | App Version | Description |
|-------|---------|-------------|-------------|
| [cloudflared](./charts/cloudflared) | 0.2.1 | 2024.11.0 | Deploy Cloudflare Tunnel for secure ingress |
| [karpenter-nodepool](./charts/karpenter-nodepool) | 1.5.1 | 1.5.0 | Karpenter NodePool and EC2NodeClass resources |
| [log-generator](./charts/log-generator) | 0.1.1 | latest | Configurable log generator for testing and benchmarking |
| [cronjobs](./charts/cronjobs) | 0.1.0 | 1.16.0 | Generic CronJobs deployment chart |
| [mop](./charts/mop) | 0.7.0 | 1.0.0 | Generic Helm chart for deploying Go microservices (Microservices Observability Platform) |
| [grafana](./charts/grafana) | 0.1.0 | 1.0.0 | Grafana dashboards with ConfigMap and GrafanaDashboard CRD support |

## Quick Start

### cloudflared - Cloudflare Tunnel

```bash
# Install with default values
helm install cloudflared duyhenryer/cloudflared

# Install with custom configuration
helm install cloudflared duyhenryer/cloudflared \
  --set cloudflare.tunnelName="my-tunnel" \
  --set cloudflare.tunnelId="tunnel-id" \
  --set cloudflare.secret="tunnel-secret"
```

### karpenter-nodepool - Karpenter Node Management

```bash
# Install with default values
helm install karpenter-nodes duyhenryer/karpenter-nodepool

# Install with spot instances and custom limits
helm install karpenter-nodes duyhenryer/karpenter-nodepool \
  --set nodePool.default.requirements[0].key="karpenter.sh/capacity-type" \
  --set nodePool.default.requirements[0].operator="In" \
  --set nodePool.default.requirements[0].values[0]="spot" \
  --set nodePool.default.limits.cpu=500

# Install with custom values file
helm install karpenter-nodes duyhenryer/karpenter-nodepool -f my-values.yaml
```

### log-generator - Log Generator for Testing

```bash
# Install with default values (generates infinite logs)
helm install log-generator duyhenryer/log-generator

# Install with custom values file
helm install log-generator duyhenryer/log-generator -f my-values.yaml
```

### cronjobs - Generic CronJobs

```bash
# Install with default values
helm install my-cronjobs duyhenryer/cronjobs

# Install with custom values file
helm install my-cronjobs duyhenryer/cronjobs -f values.yaml
```

### mop - Microservices Observability Platform

```bash
# Install a microservice with SLO enabled
helm install auth duyhenryer/mop \
  --set name=auth \
  --set image.repository=ghcr.io/duynhne/auth-service/auth \
  --set image.tag=latest \
  --set slo.enabled=true \
  --namespace auth

# Lint with SLO
helm lint charts/mop/ --set name=test --set slo.enabled=true
```

### grafana - Grafana Dashboard Chart

```bash
# Install a Grafana dashboard
helm install my-dashboard duyhenryer/grafana \
  --set dashboard.name=my-dashboard \
  --set dashboard.folder=MyFolder
```

## Using OCI Registry

```bash
# Pull and install cloudflared
helm install cloudflared oci://ghcr.io/duyhenryer/charts/cloudflared --version 0.2.1

# Pull and install karpenter-nodepool
helm install karpenter-nodes oci://ghcr.io/duyhenryer/charts/karpenter-nodepool --version 1.5.1

# Pull and install log-generator
helm install log-generator oci://ghcr.io/duyhenryer/charts/log-generator --version 0.1.3

# Pull and install cronjobs
helm install my-cronjobs oci://ghcr.io/duyhenryer/charts/cronjobs --version 0.1.0

# Pull and install mop
helm install auth oci://ghcr.io/duyhenryer/charts/mop --version 0.7.0

# Pull and install grafana dashboard
helm install my-dashboard oci://ghcr.io/duyhenryer/charts/grafana --version 0.1.0
```