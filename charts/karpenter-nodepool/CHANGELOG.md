# Changelog

All notable changes to this project will be documented in this file.

## [Next Release]

- TODO: Future improvements

---

## v1.2.0

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm) ![Karpenter: v1.6.3](https://img.shields.io/badge/Karpenter-v1.6.3-success?color=success&logo=kubernetes)

> **📖 Reference**: [Karpenter v1.6 Getting Started guide](https://karpenter.sh/v1.6/getting-started/)

⚠️ **BREAKING CHANGE: Per-NodePool Overprovisioning**

### Breaking Changes

- **Overprovisioning configuration moved from top-level to per-nodepool**
- Each nodepool can now have independent overprovisioning settings
- Automatic nodeAffinity injection to bind dummy pods to specific nodepools

### What's New

- **Per-nodepool overprovisioning**: Configure overprovisioning independently for each nodepool
- **Auto-binding**: Dummy pods automatically scheduled to their target nodepool via nodeAffinity
- **Tolerations support**: Add tolerations to match nodepool taints
- **TopologySpreadConstraints support**: Distribute dummy pods across AZs
- **PriorityClass deduplication**: Multiple nodepools can share the same PriorityClass

### Usage Example

```yaml
nodePool:
  general:
    taints:
      - key: workload
        value: general
        effect: NoSchedule
    overprovisioning:
      enabled: true
      replicas: 2
      tolerations:
        - key: workload
          value: general
          effect: NoSchedule
  
  spot:
    requirements:
      - key: karpenter.sh/capacity-type
        operator: In
        values: ["spot"]
    overprovisioning:
      enabled: true
      replicas: 5
      doNotDisrupt: false  # Allow consolidation on spot
```

### Key Changes

- Added `templates/priorityclass.yaml` with deduplication logic
- Added `templates/deployment-overprovisioning.yaml` with per-nodepool loop
- Extended `values.yaml` with per-nodepool overprovisioning configuration
- Chart version bumped to 1.2.0 (breaking change release)

### Trade-offs

- `doNotDisrupt: true`: Nodes always ready (instant scaling) but run 24/7 (higher cost)
- `doNotDisrupt: false`: Cost-optimized (Karpenter consolidates when idle) but may lose spare capacity

Verified with Karpenter v1.6.1–v1.6.3.

---

## v1.1.0

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm) ![Karpenter: v1.6.3](https://img.shields.io/badge/Karpenter-v1.6.3-success?color=success&logo=kubernetes)

> **📖 Reference**: [Karpenter v1.6 Getting Started guide](https://karpenter.sh/v1.6/getting-started/)

### Key Changes

- Chart metadata bumped to version 1.1.0; appVersion set to 1.6.0
- Values and templates updated for Karpenter v1.6 semantics
  - NodePool: disruption budgets notes for cron `schedule` and `duration`
  - Requirements: retain `minValues` pass-through
  - EC2NodeClass: clarify `alias` AMI selection and IMDSv2 defaults; `instanceStorePolicy`, `associatePublicIPAddress`, `detailedMonitoring`, and `kubelet` remain pass-through
- Documentation comments refreshed to v1.6 across templates and values

### Compatibility

- APIs remain stable: `karpenter.sh/v1` and `karpenter.k8s.aws/v1`
- Kubelet configuration continues to live on `EC2NodeClass` (v1.5+)

### Notes

- Review NodePool `requirements` and consider `minValues` where useful
- Consider explicitly setting `associatePublicIPAddress` and `detailedMonitoring` if desired
- No spec moves needed; kubelet stays under `EC2NodeClass.spec.kubelet`

Verified against Karpenter patch releases:
- v1.6.1 (Chores)
- v1.6.2 (Fix: allow termination for drifted nodes when consolidation disabled)
- v1.6.3 (Fix: support arbitrary reserved capacity labels for drift)
No chart template changes required.

---

## v1.0.0

![Helm: v3](https://img.shields.io/badge/Helm-v3.14%2B-informational?color=informational&logo=helm) ![Karpenter: v1.5.4](https://img.shields.io/badge/Karpenter-v1.5.4-success?color=success&logo=kubernetes)

**🚀 MAJOR RELEASE: Full Karpenter v1.5.x Series Support**

> **📖 Reference**: [Karpenter v1.5 Getting Started guide](https://karpenter.sh/v1.5/getting-started/) | **Latest Tested**: v1.5.4

### 🎯 **Key Changes Summary**

This release brings **full compatibility** with Karpenter v1.5.x series, following the [official v1.5 architecture](https://karpenter.sh/v1.5/getting-started/):

| **Change** | **v0.2.0 (Old)** | **v1.5.0 (New)** | **Impact** |
|------------|-------------------|-------------------|------------|
| **Kubelet Config** | `nodePool.kubelet` | `ec2NodeClass.kubelet` | **BREAKING** |
| **API Versions** | `v1beta1` APIs | Stable `v1` APIs | **BREAKING** |
| **AMI Selection** | Tag-based only | **AMI Aliases** (`al2@latest`) | **ENHANCED** |
| **Disruption** | Basic policies | **Time-based budgets** | **NEW** |
| **Security** | Basic IMDS | **IMDSv2 hardening** | **ENHANCED** |

### 🔥 **Critical Breaking Change**
```yaml
# ❌ OLD (v0.2.0) - No longer works
nodePool:
  kubelet:
    maxPods: 110

# ✅ NEW (v1.5.0) - Required location
ec2NodeClass:
  kubelet:
    maxPods: 110
```

### 🆕 **What's New in v1.5**
- **AMI Aliases**: Automatic EKS-optimized AMI selection (`al2@latest`, `al2023@latest`)
- **Disruption Budgets**: Time-based scheduling with business hours protection
- **Capacity Reservations**: Alpha support for on-demand reserved instances  
- **Security Hardening**: IMDSv2 with container isolation (`httpPutResponseHopLimit: 1`)
- **Performance**: RAID0 instance stores, GP3 storage optimization, faster EBS initialization

### 🔄 **API Changes**
```yaml
# Stable APIs (no more beta!)
apiVersion: karpenter.sh/v1          # was: karpenter.sh/v1beta1
apiVersion: karpenter.k8s.aws/v1     # was: karpenter.k8s.aws/v1beta1
```

### ⚠️ **Compatibility**
- ✅ **Supports**: Karpenter v1.5.0 through v1.5.4 (tested with latest v1.5.4)
- ✅ **Future**: Compatible with upcoming v1.5.x patch releases
- ❌ **Dropped**: Karpenter v0.x.x series (breaking changes)
- 🔄 **Migration**: Required for existing v0.2.0 users

### 🔧 **Quick Migration from v0.2.0**
```bash
# 1. Move kubelet config
# FROM: nodePool.kubelet → TO: ec2NodeClass.kubelet

# 2. Use AMI aliases (recommended)
amiSelectorTerms:
  - alias: al2@latest  # instead of tag selectors

# 3. Test in staging first!
# 4. Review: https://karpenter.sh/v1.5/getting-started/
```

> **⚠️ Important**: This is a major breaking change. Test thoroughly in non-production before upgrading.

---