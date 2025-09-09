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

## Using OCI Registry

```bash
# Pull and install cloudflared
helm install cloudflared oci://ghcr.io/duyhenryer/charts/cloudflared --version 0.2.1

# Pull and install karpenter-nodepool
helm install karpenter-nodes oci://ghcr.io/duyhenryer/charts/karpenter-nodepool --version 1.5.1
```