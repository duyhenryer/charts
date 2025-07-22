# Karpenter NodePool Helm Chart

A Helm chart for deploying Karpenter NodePool and EC2NodeClass resources on Amazon EKS clusters.

## Overview

This Helm chart simplifies the deployment of Karpenter NodePool and EC2NodeClass custom resources, which are essential for Karpenter's node provisioning and management capabilities on AWS EKS clusters.

## Prerequisites

- Kubernetes cluster with Karpenter installed
- AWS EKS cluster with proper IAM roles configured
- Helm 3.x installed

## Installation

### Add the Helm repository

```bash
helm repo add karpenter-nodepool https://duyhenryer.github.io/charts/
helm repo update
```

### Install the chart

```bash
# Install with default values
helm install my-karpenter-nodepool karpenter-nodepool/karpenter-nodepool

# Install with custom values
helm install my-karpenter-nodepool karpenter-nodepool/karpenter-nodepool -f values.yaml

# Install with specific values
helm install my-karpenter-nodepool karpenter-nodepool/karpenter-nodepool \
  --set nodePool.default.expireAfter=24h \
  --set nodePool.default.limits.cpu=500
```

## Configuration

### NodePool Configuration

The NodePool resource defines the requirements and constraints for node provisioning:

```yaml
nodePool:
  default:
    # Node labels
    labels: {}
    
    # Node annotations
    annotations: {}
    
    # Reference to EC2NodeClass
    nodeClassRef:
      group: karpenter.k8s.aws
      kind: EC2NodeClass
      name: default
    
    # Node taints
    taints: []
    
    # Startup taints (temporary)
    startupTaints: []
    
    # Node expiration time
    expireAfter: 720h
    
    # Node requirements
    requirements:
      - key: "karpenter.k8s.aws/instance-category"
        operator: In
        values: ["c", "m", "r"]
      - key: "karpenter.sh/capacity-type"
        operator: In
        values: ["spot", "on-demand"]
    
    # Kubelet configuration
    kubelet: {}
    
    # Disruption policy
    disruption:
      consolidationPolicy: WhenUnderutilized
    
    # Resource limits
    limits:
      cpu: 1000
      memory: 1000Gi
```

### EC2NodeClass Configuration

The EC2NodeClass resource defines AWS-specific configuration for node provisioning:

```yaml
ec2NodeClass:
  default:
    # AMI family
    amiFamily: AL2
    
    # Subnet selectors
    subnetSelectorTerms:
      - tags:
          karpenter.sh/discovery: my-cluster
    
    # Security group selectors
    securityGroupSelectorTerms:
      - tags:
          karpenter.sh/discovery: my-cluster
    
    # IAM role or instance profile
    role: "arn:aws:iam::123456789012:role/KarpenterNodeRole"
    
    # AMI selectors
    amiSelectorTerms:
      - name: "amazon-eks-node-al2023-x86_64-standard-1.32-*"
    
    # User data
    userData: ""
    
    # Tags for EC2 resources
    tags: {}
    
    # Metadata options
    metadataOptions:
      httpEndpoint: enabled
      httpTokens: required
    
    # Block device mappings
    blockDeviceMappings: []
    
    # Detailed monitoring
    detailedMonitoring: false
    
    # Public IP association
    associatePublicIPAddress: false
```

## Version Compatibility

| karpenter-nodepool version | karpenter version |
|---------------------------|-------------------|
| 1.5.1                     | 1.5.0             |
| 1.5.0                     | 1.5.0             |
| 1.3.0                     | 1.3.0             |

## Examples

### Basic NodePool with Spot Instances

```yaml
nodePool:
  spot:
    nodeClassRef:
      name: default
    requirements:
      - key: "karpenter.sh/capacity-type"
        operator: In
        values: ["spot"]
      - key: "karpenter.k8s.aws/instance-category"
        operator: In
        values: ["c", "m", "r"]
    limits:
      cpu: 100
      memory: 100Gi
    expireAfter: 24h
```

### On-Demand NodePool for Critical Workloads

```yaml
nodePool:
  ondemand:
    nodeClassRef:
      name: default
    requirements:
      - key: "karpenter.sh/capacity-type"
        operator: In
        values: ["on-demand"]
      - key: "karpenter.k8s.aws/instance-generation"
        operator: Gt
        values: ["2"]
    taints:
      - key: "workload-type"
        value: "critical"
        effect: NoSchedule
    limits:
      cpu: 200
      memory: 400Gi
```

### Multi-Architecture NodePool

```yaml
nodePool:
  multiarch:
    nodeClassRef:
      name: default
    requirements:
      - key: "kubernetes.io/arch"
        operator: In
        values: ["amd64", "arm64"]
    limits:
      cpu: 50
      memory: 100Gi
```

## Upgrading

```bash
# Upgrade to a new version
helm upgrade my-karpenter-nodepool karpenter-nodepool/karpenter-nodepool

# Upgrade with custom values
helm upgrade my-karpenter-nodepool karpenter-nodepool/karpenter-nodepool -f values.yaml
```

## Uninstalling

```bash
# Uninstall the chart
helm uninstall my-karpenter-nodepool

# Note: This will not delete the NodePool and EC2NodeClass resources
# You may need to delete them manually if needed
kubectl delete nodepool default
kubectl delete ec2nodeclass default
```

## Troubleshooting

### Check NodePool Status

```bash
kubectl get nodepools
kubectl describe nodepool default
```

### Check EC2NodeClass Status

```bash
kubectl get ec2nodeclasses
kubectl describe ec2nodeclass default
```

### Check Karpenter Logs

```bash
kubectl logs -n karpenter -l app.kubernetes.io/name=karpenter
```

### Common Issues

1. **IAM Role Issues**: Ensure the IAM role has proper permissions for EC2 operations
2. **Subnet/Security Group Issues**: Verify subnet and security group selectors are correct
3. **AMI Issues**: Check if the specified AMI exists and is accessible

## License

This project is licensed under the MIT License.

## Support

For support and questions:
- Create an issue on GitHub
- Contact: hello@duyne.me
- Website: https://duyne.me 